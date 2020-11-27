//
//  UpComing2Widget.swift
//  UpComing2Widget
//
//  Created by Doyeong Yeom on 2020/11/26.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @Environment(\.widgetFamily) var family
    
    func placeholder(in context: Context) -> UpComing2WidgetEntry {
        UpComing2WidgetEntry(date: Date(), events: (events[0], events[1]))
    }

    func getSnapshot(in context: Context, completion: @escaping (UpComing2WidgetEntry) -> ()) {
        let entry = UpComing2WidgetEntry(date: Date(), events: (events[0], events[1]))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let upcomingEvents = getUpcomingEvents()
        
        let entry: UpComing2WidgetEntry
        let reloadPolicy: TimelineReloadPolicy
        if let sessionEndTime = getRefreshDate(upcomingEvents: upcomingEvents) {
            entry = UpComing2WidgetEntry(date: sessionEndTime, events: upcomingEvents)
            reloadPolicy = .atEnd
        } else {
            entry = UpComing2WidgetEntry(date: Date(), events: upcomingEvents)
            reloadPolicy = .after(Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        }
        let timeline = Timeline(entries: [entry], policy: reloadPolicy)
        completion(timeline)
    }
    
    func getUpcomingEvents() -> (Event?, Event?) {
        let dateManager = DateManager()
        var upcomingEvents: (Event?, Event?) = (nil, nil)
        
        for event in events.enumerated() {
            guard let sessionTime = dateManager.stringDateConvert(date: event.element.date, time: event.element.time) else { continue }
            if Date().timeIntervalSince1970 < sessionTime.end.timeIntervalSince1970 {
                if event.offset > events.count - 2 {
                    upcomingEvents = (events[event.offset], nil)
                } else {
                    upcomingEvents = (events[event.offset], events[event.offset + 1])
                }
                break
            }
        }
        return upcomingEvents
    }
    
    func getRefreshDate(upcomingEvents: (Event?, Event?)) -> Date? {
        guard let event = upcomingEvents.0 else { return nil }
        let dateManager = DateManager()
        return dateManager.stringDateConvert(date: event.date, time: event.time)?.end
    }
}

struct UpComing2WidgetEntry: TimelineEntry {
    var date: Date
    let events: (Event?, Event?)
}

struct UpComing2SmallView: View {
    let events: (Event?, Event?)
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(events.0?.title ?? "다음 이벤트가 없습니다")
                    .font(.caption)
                    .fontWeight(.bold)
                Text([events.0?.date, events.0?.dayOfTheWeek, events.0?.time].compactMap { $0 }.joined(separator: " "))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .frame(maxHeight: .infinity)
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                Text(events.1?.title ?? "다음 이벤트가 없습니다")
                    .font(.caption)
                    .fontWeight(.bold)
                Text([events.1?.date, events.1?.dayOfTheWeek, events.1?.time].compactMap { $0 }.joined(separator: " "))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .frame(maxHeight: .infinity)
        }
    }
}

struct UpComing2MediumView: View {
    let events: (Event?, Event?)
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(events.0?.title ?? "다음 이벤트가 없습니다")
                    .font(.caption)
                    .fontWeight(.bold)
                Text([events.0?.date, events.0?.dayOfTheWeek].compactMap { $0 }.joined(separator: " "))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Text(events.0?.time ?? "")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            Divider()
            VStack(alignment: .leading) {
                Text(events.1?.title ?? "다음 이벤트가 없습니다")
                    .font(.caption)
                    .fontWeight(.bold)
                Text([events.1?.date, events.1?.dayOfTheWeek].compactMap { $0 }.joined(separator: " "))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Text(events.1?.time ?? "")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
    }
}

struct UpComing2WidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    let events: (Event?, Event?)
    
    var body: some View {
        if family == .systemSmall {
            UpComing2SmallView(events: events)
        } else if family == .systemMedium {
            UpComing2MediumView(events: events)
        }
    }
}

@main
struct UpComing2Widget: Widget {
    let kind: String = "UpComing2Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            UpComing2WidgetEntryView(events: entry.events)
        }
        .configurationDisplayName("Let's Swift 2020")
        .description("다음 이벤트를 확인하시고 놓치지 마세요!")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview
struct UpComing2Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UpComing2WidgetEntryView(events: (events[0], events[1]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            UpComing2WidgetEntryView(events: (events[0], events[1]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
