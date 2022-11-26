//
//  ScheduleWidget.swift
//  ScheduleWidget
//
//  Created by Doyeong Yeom on 2020/11/26.
//

import WidgetKit
import SwiftUI

// MARK: - Entry
struct ScheduleWidgetEntry: TimelineEntry {
    var date: Date
}

// MARK: - Widget
@main
struct ScheduleWidget: Widget {
    let kind: String = "ScheduleWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ScheduleWidgetEntryView(events: Event.events)
        }
        .configurationDisplayName("Let's Swift 2020")
        .description("일정을 확인하시고 절대 놓치지 마세요!")
        .supportedFamilies([.systemLarge])
    }
}

struct ScheduleWidgetEntryView: View {
    let events: [Event]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Let's Swift 2020")
                .font(.headline)
                .fontWeight(.black)
                .foregroundColor(.orange)
            VStack(alignment: .leading, spacing: 12) {
                ForEach(events) { event in
                    VStack(alignment: .leading, spacing: 3) {
                        Text(event.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        HStack {
                            Text("\(event.startsAt.readableDate)")
                                .fontWeight(.semibold)
                            Text("\(event.startsAt.readableTime) ~ \(event.endsAt.readableTime)")
                        }
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    }
                    if events.last?.id != event.id {
                        Divider()
                    }
                }
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct ScheduleWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScheduleWidgetEntryView(events: Event.events)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            ScheduleWidgetEntryView(events: Event.events)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .environment(\.sizeCategory, .extraLarge)
        }
    }
}
