//
//  UpComing2Widget.swift
//  UpComing2Widget
//
//  Created by Doyeong Yeom on 2020/11/26.
//

import WidgetKit
import SwiftUI

// MARK: - Entry
struct UpComing2WidgetEntry: TimelineEntry {
    var date: Date
    let events: (Event?, Event?)
}

// MARK: - Widget
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

struct UpComing2SmallView: View {
    let events: (Event?, Event?)
    
    var body: some View {
        ZStack {
            Color.orange
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white,
                                                                 Color.gray,
                                                                 Color.black]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .opacity(0.1)
            VStack(alignment: .leading) {
                HStack {
                    if let event = events.0 {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .font(.caption)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(event.startsAt.readableDate)")
                                    .fontWeight(.semibold)
//                                Text("\(event.startsAt.readableTime) ~ \(event.endsAt.readableTime)")
//                                    .fontWeight(.semibold)
                            }
                            .font(.caption2)
                            .foregroundColor(.white)
                            .opacity(0.75)
                            Spacer()
                        }
                        Spacer()
                    } else {
                        FailureView()
                    }
                }
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    if let event = events.1 {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .font(.caption)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(event.startsAt.readableDate)")
                                    .fontWeight(.semibold)
//                                Text("\(event.startsAt.readableTime) ~ \(event.endsAt.readableTime)")
//                                    .fontWeight(.semibold)
                            }
                            .font(.caption2)
                            .foregroundColor(.white)
                            .opacity(0.75)
                            Spacer()
                        }
                        Spacer()
                    } else {
                        FailureView()
                    }
                }
            }
            .padding()
        }
    }
}

struct UpComing2MediumView: View {
    let events: (Event?, Event?)
    
    var body: some View {
        ZStack {
            Color.orange
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white,
                                                                 Color.gray,
                                                                 Color.black]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .opacity(0.1)
            VStack(alignment: .leading, spacing: 8) {
                Text("Let's Swift 2020")
                    .font(.headline)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                HStack(alignment: .center) {
                    if let event = events.0 {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(event.startsAt.readableDate)")
                                    .fontWeight(.semibold)
                                Text("\(event.startsAt.readableTime) ~ \(event.endsAt.readableTime)")
                                    .fontWeight(.semibold)
                            }
                            .font(.caption)
                            .foregroundColor(.white)
                            .opacity(0.75)
                        }
                        Spacer()
                    } else {
                        FailureView()
                    }
                    Divider()
                    if let event = events.1 {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(event.startsAt.readableDate)")
                                    .fontWeight(.semibold)
                                Text("\(event.startsAt.readableTime) ~ \(event.endsAt.readableTime)")
                                    .fontWeight(.semibold)
                            }
                            .font(.caption)
                            .foregroundColor(.white)
                            .opacity(0.75)
                        }
                        Spacer()
                    } else {
                        FailureView()
                    }
                }
            }
            .padding()
        }
    }
}

struct FailureView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("다음 이벤트가 없습니다.")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(0.75)
                Spacer()
            }
            Spacer()
        }
    }
}

// MARK: - Preview
struct UpComing2Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UpComing2WidgetEntryView(events: (nil, nil))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            UpComing2WidgetEntryView(events: (Event.events[0], Event.events[1]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            UpComing2WidgetEntryView(events: (nil, nil))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            UpComing2WidgetEntryView(events: (Event.events[0], Event.events[1]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
