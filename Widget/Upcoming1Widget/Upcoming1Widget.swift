//
//  UpComing1Widget.swift
//  UpComing1Widget
//
//  Created by Doyeong Yeom on 2020/11/26.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @Environment(\.widgetFamily) var family
    
    func placeholder(in context: Context) -> UpComing1WidgetEntry {
        UpComing1WidgetEntry(date: Date(), event: Event.events[0])
    }

    func getSnapshot(in context: Context, completion: @escaping (UpComing1WidgetEntry) -> ()) {
        let entry = UpComing1WidgetEntry(date: Date(), event: Event.events[0])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let upcomingEvent: Event? = getUpcomingEvent()
        
        let entry: UpComing1WidgetEntry
        let reloadPolicy: TimelineReloadPolicy
        if let date = getReloadDate(upcomingEvent: upcomingEvent) {
            entry = UpComing1WidgetEntry(date: date, event: upcomingEvent)
            reloadPolicy = .atEnd
        } else {
            entry = UpComing1WidgetEntry(date: Date(), event: upcomingEvent)
            reloadPolicy = .after(Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        }
        let timeline = Timeline(entries: [entry], policy: reloadPolicy)
        completion(timeline)
    }
    
    func getUpcomingEvent() -> Event? {
        for event in Event.events {
            if Date().timeIntervalSince1970 < event.endsAt.timeIntervalSince1970 {
                return event
            }
        }
        return nil
    }

    func getReloadDate(upcomingEvent: Event?) -> Date? {
        guard let event = upcomingEvent else { return nil }
        return event.endsAt
    }
}

struct UpComing1WidgetEntry: TimelineEntry {
    var date: Date
    var event: Event?
}

struct UpComing1SmallView: View {
    let event: Event?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("Placeholder")
                .resizable()
            Color.black.opacity(0.5)
            VStack(alignment: .leading, spacing: 4) {
                Text(event?.title ?? "다음 이벤트가 없습니다")
                    .font(.caption)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text([event?.date, event?.dayOfTheWeek].compactMap { $0 }.joined(separator: " "))
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.white.opacity(0.75))
                Text(event?.time ?? "")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white.opacity(0.75))
            }
            .padding()
            .foregroundColor(.white)
        }
    }
}

struct UpComing1MediumView: View {
    let event: Event?
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(event?.title ?? "다음 이벤트가 없습니다")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text([event?.date, event?.dayOfTheWeek, event?.time].compactMap { $0 }.joined(separator: " "))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    Text(event?.description ?? "")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                Spacer()
                Image("Placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.height)
                    .clipped()
            }
        }
    }
}

struct UpComing1LargeView: View {
    let event: Event?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                Image("Placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: geometry.size.height * 0.6)
                    .clipped()
                VStack(alignment: .leading, spacing: 8) {
                    Text(event?.title ?? "다음 이벤트가 없습니다")
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text([event?.startsAt.readableDate, event?.startsAt.readableDayOfWeek, event?.startsAt.readableTime, event?.endsAt.readableTime].compactMap { $0 }.joined(separator: " "))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    Text(event?.description ?? "")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct UpComing1WidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    let event: Event?
    
    var body: some View {
        if family == .systemSmall {
            UpComing1SmallView(event: event)
        } else if family == .systemMedium {
            UpComing1MediumView(event: event)
        } else if family == .systemLarge {
            UpComing1LargeView(event: event)
        }
    }
}

@main
struct UpComing1Widget: Widget {
    let kind: String = "UpComing1Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            UpComing1WidgetEntryView(event: entry.event)
        }
        .configurationDisplayName("Let's Swift 2020")
        .description("다음 이벤트를 확인하시고 놓치지 마세요!")
    }
}

// MARK: - Preview
struct UpComing1Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UpComing1WidgetEntryView(event: Event.events[0])
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            UpComing1WidgetEntryView(event: Event.events[0])
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            UpComing1WidgetEntryView(event: Event.events[0])
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
