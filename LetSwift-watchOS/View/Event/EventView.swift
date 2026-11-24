//
//  EventView.swift
//  LetSwift-watchOS Watch App
//

import SwiftUI

/// Main screen: the current Let'Swift event, plus the timetable when the event has one.
struct EventView: View {
    @State private var eventViewModel = EventViewModel()
    @State private var sessionViewModel = WatchSessionViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if let event = eventViewModel.event {
                        EventCard(event: event)
                    } else if eventViewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .accessibilityLabel("event.loading")
                    } else {
                        noEventView
                    }

                    if !sessionViewModel.sessions.isEmpty {
                        NavigationLink {
                            TimetableView(viewModel: sessionViewModel)
                        } label: {
                            Label("event.timetable", systemImage: "list.bullet.rectangle")
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
            .navigationTitle("Let'Swift")
        }
        .task {
            let startedEmpty = eventViewModel.event == nil
            async let event: Void = eventViewModel.load()
            async let sessions: Void = sessionViewModel.loadSessionsOnce()
            _ = await (event, sessions)
            // VoiceOver: the spinner gave way to the "no event" message; say so once, without moving focus.
            if startedEmpty, eventViewModel.event == nil, !Task.isCancelled {
                VoiceOver.announce(String(localized: "event.none.title"))
            }
        }
    }

    private var noEventView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("event.none.title")
                .font(.headline)
            Text("event.none.message")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}

private struct EventCard: View {
    let event: CalendarEvent

    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // VoiceOver: one heading, name first. "Let'Swift 2026, 12 days left" rather than "D-12".
            VStack(alignment: .leading, spacing: 8) {
                statusBadge

                Text(event.title)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Text(event.title.isEmpty ? "Let'Swift" : event.title))
            .accessibilityValue(spokenStatus)
            .accessibilityAddTraits(.isHeader)

            // VoiceOver: date, time and place in one swipe, with full weekday and month names.
            VStack(alignment: .leading, spacing: 4) {
                Label {
                    Text(event.startDate, format: .dateTime.month().day().weekday())
                } icon: {
                    Image(systemName: "calendar")
                }
                .accessibilityLabel(Text(event.startDate, format: .dateTime.month(.wide).day().weekday(.wide)))
                if !event.isAllDay {
                    Label {
                        Text(event.startDate..<event.endDate, format: .interval.hour().minute())
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .accessibilityLabel(spokenTimeRange)
                }
                if let location = event.location {
                    Label(location, systemImage: "mappin.and.ellipse")
                        .lineLimit(3)
                }
            }
            .font(.footnote)
            .foregroundStyle(.secondary)
            .accessibilityElement(children: .combine)

            if let location = event.location, let mapsURL = Self.mapsURL(for: location) {
                Button("event.openMaps", systemImage: "map") {
                    openURL(mapsURL)
                }
            }
        }
    }

    @ViewBuilder
    private var statusBadge: some View {
        Group {
            switch event.status() {
            case .upcoming(let days):
                Text("event.status.dday \(days)")
            case .today:
                Text("event.status.today")
            case .live:
                Text("event.status.live")
            case .ended:
                Text("event.status.ended")
            }
        }
        .font(.caption.weight(.semibold))
        .foregroundStyle(Color(hex: "F14D35"))
    }

    /// The status badge in words: "D-12" becomes "12 days left".
    private var spokenStatus: Text {
        switch event.status() {
        case .upcoming(let days): Text("event.status.daysLeft \(days)")
        case .today: Text("event.status.today")
        case .live: Text("event.status.live")
        case .ended: Text("event.status.ended")
        }
    }

    /// "10:00 AM to 4:00 PM": the dash in the visible interval is not reliably spoken as "to".
    /// An event that spans days keeps the system's interval text, which names both dates.
    private var spokenTimeRange: Text {
        guard Calendar.current.isDate(event.startDate, inSameDayAs: event.endDate) else {
            return Text(event.startDate..<event.endDate, format: .interval.hour().minute())
        }
        let start = event.startDate.formatted(date: .omitted, time: .shortened)
        let end = event.endDate.formatted(date: .omitted, time: .shortened)
        return Text("time.range \(start) \(end)")
    }

    private static func mapsURL(for location: String) -> URL? {
        var components = URLComponents(string: "https://maps.apple.com/")
        components?.queryItems = [URLQueryItem(name: "q", value: location)]
        return components?.url
    }
}

#Preview {
    EventView()
}
