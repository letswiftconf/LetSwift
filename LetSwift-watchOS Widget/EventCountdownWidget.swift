//
//  EventCountdownWidget.swift
//  LetSwift-watchOS Widget
//
//  Countdown to the current Let'Swift event, for complications and the Smart Stack.
//

import OSLog
import SwiftUI
import WidgetKit

@main
struct LetSwiftWatchWidgets: WidgetBundle {
    var body: some Widget {
        EventCountdownWidget()
    }
}

struct EventCountdownWidget: Widget {
    let kind = "EventCountdown"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: EventProvider()) { entry in
            EventCountdownView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("widget.name")
        .description("widget.description")
        .supportedFamilies([
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline,
            .accessoryCorner,
        ])
    }
}

// MARK: - Timeline

struct EventEntry: TimelineEntry {
    let date: Date
    let event: CalendarEvent
    var isPlaceholder = false
}

struct EventProvider: TimelineProvider {
    func placeholder(in context: Context) -> EventEntry {
        EventEntry(date: .now, event: .placeholder, isPlaceholder: true)
    }

    func getSnapshot(in context: Context, completion: @escaping @Sendable (EventEntry) -> Void) {
        if context.isPreview, let cached = EventStore.cached() {
            completion(EventEntry(date: .now, event: cached))
            return
        }
        Task {
            if let event = await EventStore.load() {
                completion(EventEntry(date: .now, event: event))
            } else {
                completion(EventEntry(date: .now, event: .placeholder, isPlaceholder: true))
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<EventEntry>) -> Void) {
        Task {
            let now = Date.now
            guard let event = await EventStore.load() else {
                // Nothing loaded and nothing cached: show the placeholder and retry in an hour.
                let entry = EventEntry(date: now, event: .placeholder, isPlaceholder: true)
                completion(Timeline(entries: [entry], policy: .after(now.addingTimeInterval(3600))))
                return
            }
            completion(Self.timeline(for: event, from: now))
        }
    }

    /// One entry now, one at each midnight until the event day (so D-n stays right),
    /// and one at the start and the end. Reloads (refetching the .ics) the next day.
    static func timeline(for event: CalendarEvent, from now: Date, calendar: Calendar = .current) -> Timeline<EventEntry> {
        var dates: [Date] = [now, event.startDate, event.endDate]
        var midnight = calendar.startOfDay(for: now)
        let eventDay = calendar.startOfDay(for: event.startDate)
        for _ in 0..<14 {
            guard let next = calendar.date(byAdding: .day, value: 1, to: midnight), next <= eventDay else { break }
            dates.append(next)
            midnight = next
        }
        let entries = Set(dates.filter { $0 >= now })
            .sorted()
            .map { EventEntry(date: $0, event: event) }

        let tomorrow = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now)) ?? now.addingTimeInterval(86_400)
        return Timeline(entries: entries, policy: .after(tomorrow))
    }
}

// MARK: - Data

/// Fetches the event from letswift.kr and keeps the last good copy for offline use.
enum EventStore {
    private static let logger = Logger(subsystem: "kr.codesquad.jk.letswift", category: "EventWidget")
    private static var cacheKey: String { "cachedEvent-\(LetSwiftEvent.year)" }

    static func load() async -> CalendarEvent? {
        do {
            let (data, response) = try await URLSession.shared.data(from: LetSwiftEvent.calendarURL)
            if (response as? HTTPURLResponse)?.statusCode == 200,
               let ics = String(data: data, encoding: .utf8),
               let event = CalendarEvent(ics: ics) {
                if let encoded = try? JSONEncoder().encode(event) {
                    UserDefaults.standard.set(encoded, forKey: cacheKey)
                }
                return event
            }
            logger.error("No event at \(LetSwiftEvent.calendarURL.absoluteString, privacy: .public)")
        } catch {
            logger.error("Failed to load event: \(error.localizedDescription, privacy: .public)")
        }
        return cached()
    }

    static func cached() -> CalendarEvent? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else { return nil }
        return try? JSONDecoder().decode(CalendarEvent.self, from: data)
    }
}

extension CalendarEvent {
    /// Shown while loading and in the widget gallery when nothing is cached yet.
    static var placeholder: CalendarEvent {
        let start = Calendar.current.date(byAdding: .day, value: 30, to: .now) ?? .now
        return CalendarEvent(title: "Let'Swift", startDate: start, endDate: start.addingTimeInterval(3 * 3600))
    }

    init(title: String, startDate: Date, endDate: Date) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.location = nil
        self.notes = nil
        self.url = nil
        self.isAllDay = false
    }
}

// MARK: - Views

struct EventCountdownView: View {
    let entry: EventEntry
    @Environment(\.widgetFamily) private var family

    private var status: CalendarEvent.Status { entry.event.status(at: entry.date) }

    var body: some View {
        switch family {
        case .accessoryCircular:
            circular
        case .accessoryRectangular:
            rectangular
        case .accessoryInline:
            inline
        case .accessoryCorner:
            corner
        default:
            rectangular
        }
    }

    /// "D-12", "오늘" / "Today", "진행 중" / "Now", "지난 행사" / "Past".
    private var statusText: Text {
        switch status {
        case .upcoming(let days): Text("widget.status.dday \(days)")
        case .today: Text("widget.status.today")
        case .live: Text("widget.status.live")
        case .ended: Text("widget.status.past")
        }
    }

    private var circular: some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack(spacing: 0) {
                Image(systemName: "swift")
                    .font(.system(size: 12, weight: .semibold))
                    .widgetAccentable()
                statusText
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
            .padding(2)
        }
        .redacted(reason: entry.isPlaceholder ? .placeholder : [])
    }

    private var rectangular: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack(spacing: 4) {
                Image(systemName: "swift")
                Text(verbatim: "Let'Swift")
                Spacer(minLength: 0)
                statusText
            }
            .font(.headline)
            .widgetAccentable()
            Text(entry.event.title)
                .font(.caption)
                .lineLimit(1)
            Text(entry.event.startDate, format: .dateTime.month().day().weekday().hour().minute())
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .redacted(reason: entry.isPlaceholder ? .placeholder : [])
    }

    private var inline: some View {
        Text("widget.inline \(statusText)")
    }

    private var corner: some View {
        statusText
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .widgetAccentable()
            .widgetLabel {
                Text(verbatim: "Let'Swift")
            }
    }
}

#Preview("Rectangular", as: .accessoryRectangular) {
    EventCountdownWidget()
} timeline: {
    EventEntry(date: .now, event: .placeholder)
}
