//
//  ScheduleWidget.swift
//  ScheduleWidget
//
//  Created by Doyeong Yeom on 2020/11/26.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ScheduleWidgetEntry {
        ScheduleWidgetEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (ScheduleWidgetEntry) -> ()) {
        let entry = ScheduleWidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [ScheduleWidgetEntry(date: Date())], policy: .never)
        completion(timeline)
    }
}

struct ScheduleWidgetEntry: TimelineEntry {
    var date: Date
}

struct ScheduleWidgetEntryView : View {
    let events: [Event]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Let's Swift Conference 2020")
                .font(.headline)
                .padding([.leading, .trailing], 10)
            ForEach(events) { event in
                VStack(alignment: .leading, spacing: 2) {
                    Text(event.title)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .padding([.leading, .trailing], 10)
                    Text("\(event.date) \(event.dayOfTheWeek) \(event.time)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding([.leading, .trailing], 10)
                }
                if events.last?.id != event.id {
                    Divider()
                }
            }
        }
    }
}

@main
struct ScheduleWidget: Widget {
    let kind: String = "ScheduleWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ScheduleWidgetEntryView(events: events)
        }
        .configurationDisplayName("Let's Swift 2020")
        .description("일정을 확인하시고 절대 놓치지 마세요!")
        .supportedFamilies([.systemLarge])
    }
}

struct ScheduleWidget_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleWidgetEntryView(events: events)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
