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
        UpComing1WidgetEntry(date: Date(), event: events[0])
    }

    func getSnapshot(in context: Context, completion: @escaping (UpComing1WidgetEntry) -> ()) {
        let entry = UpComing1WidgetEntry(date: Date(), event: events[0])
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
        let dateManager = DateManager()
        
        for event in events {
            guard let sessionTime = dateManager.stringDateConvert(date: event.date, time: event.time) else { continue }
            if Date().timeIntervalSince1970 < sessionTime.end.timeIntervalSince1970 {
                return event
            }
        }
        return nil
    }

    func getReloadDate(upcomingEvent: Event?) -> Date? {
        guard let event = upcomingEvent else { return nil }
        let dateManager = DateManager()
        return dateManager.stringDateConvert(date: event.date, time: event.time)?.end
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
            VStack(alignment: .leading) {
                Text(event?.title ?? "다음 이벤트가 없습니다")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing], 10)
                Text([event?.date, event?.dayOfTheWeek].compactMap { $0 }.joined(separator: " "))
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing], 10)
                Text(event?.time ?? "")
                    .font(.caption)
                    .padding([.leading, .trailing, .bottom], 10)
            }
        }
    }
}

struct UpComing1MediumView: View {
    let event: Event?
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(event?.title ?? "다음 이벤트가 없습니다")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10)
                    Text([event?.date, event?.dayOfTheWeek].compactMap { $0 }.joined(separator: " "))
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .padding([.leading, .trailing], 10)
                    Text(event?.time ?? "")
                        .font(.footnote)
                        .padding([.leading, .trailing], 10)
                    Text(event?.description ?? "")
                        .font(.caption)
                        .padding([.leading, .trailing, .bottom], 10)
                        .padding([.top], 5)
                }
                Spacer()
                Image("Placeholder")
                    .resizable().aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.25)
                    .clipped()
            }
        }
    }
}

struct UpComing1LargeView: View {
    let event: Event?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("Placeholder")
                    .resizable().aspectRatio(contentMode: .fill)
                    .frame(height: geometry.size.height * 0.5)
                    .clipped()
                VStack(alignment: .leading, spacing: 5) {
                    Text(event?.title ?? "다음 이벤트가 없습니다")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding([.leading, .trailing], 10)
                    Text([event?.date, event?.dayOfTheWeek, event?.time].compactMap { $0 }.joined(separator: " "))
                        .font(.subheadline)
                        .padding([.leading, .trailing], 10)
                    Text(event?.description ?? "")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .padding([.leading, .trailing, .bottom], 10)
                        .padding([.top], 5)
                        .truncationMode(.tail)
                }
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

struct UpComing1Widget_Previews: PreviewProvider {
    static var previews: some View {
        UpComing1WidgetEntryView(event: events[0])
    }
}
