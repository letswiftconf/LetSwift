//
//  UpComing1Widget.swift
//  UpComing1Widget
//
//  Created by Doyeong Yeom on 2020/11/26.
//

import WidgetKit
import SwiftUI

// MARK: - Entry
struct UpComing1WidgetEntry: TimelineEntry {
    var date: Date
    var event: Event?
}

// MARK: - Widget
@main
struct UpComing1Widget: Widget {
    let kind: String = "UpComing1Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            UpComing1WidgetEntryView(event: entry.event)
        }
        .configurationDisplayName("Let's Swift 2020")
        .description("다음 이벤트를 확인하시고 놓치지 마세요!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct UpComing1WidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    let event: Event?
    
    var body: some View {
        if let event = event {
            if family == .systemSmall {
                UpComing1SmallView(event: event)
            } else if family == .systemMedium {
                UpComing1MediumView(event: event)
            } else if family == .systemLarge {
                UpComing1LargeView(event: event)
            }
        } else {
            FailureView()
        }
    }
}

struct UpComing1SmallView: View {
    let event: Event
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { geometry in
                Image(event.titleImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.height)
            }
            Color.black.opacity(0.75)
            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.caption)
                    .fontWeight(.bold)
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(event.startsAt.readableDate)")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white.opacity(0.75))
                    Text("\(event.startsAt.readableTime) ~ \(event.endsAt.readableTime)")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white.opacity(0.75))
                }
            }
            .padding()
            .foregroundColor(.white)
        }
    }
}

struct UpComing1MediumView: View {
    let event: Event
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(event.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(event.startsAt.readableDate)")
                            .fontWeight(.semibold)
                        Text("\(event.startsAt.readableTime) ~ \(event.endsAt.readableTime)")
                            .fontWeight(.semibold)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    Text(event.description)
                        .font(.caption2)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                Spacer()
                Image(event.titleImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.height)
                    .clipped()
            }
        }
    }
}

struct UpComing1LargeView: View {
    let event: Event
    
    var body: some View {
        VStack(spacing: 0) {
            Image(event.titleImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(event.startsAt.readableDate)")
                        .fontWeight(.semibold)
                    Text("\(event.startsAt.readableTime) ~ \(event.endsAt.readableTime)")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                Text(event.description)
                    .font(.caption2)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
    }
}

struct FailureView: View {
    var body: some View {
        ZStack {
            Image("Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Color.black.opacity(0.75)
            Text("다음 이벤트가 없습니다.")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}

// MARK: - Preview
struct UpComing1Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UpComing1WidgetEntryView(event: nil)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            UpComing1WidgetEntryView(event: Event.events[0])
                .previewContext(WidgetPreviewContext(family: .systemSmall))
//            UpComing1WidgetEntryView(event: nil)
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
            UpComing1WidgetEntryView(event: Event.events[0])
                .previewContext(WidgetPreviewContext(family: .systemMedium))
//            UpComing1WidgetEntryView(event: nil)
//                .previewContext(WidgetPreviewContext(family: .systemLarge))
            UpComing1WidgetEntryView(event: Event.events[0])
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
