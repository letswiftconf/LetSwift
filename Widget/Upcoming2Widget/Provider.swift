//
//  Provider.swift
//  Upcoming2WidgetExtension
//
//  Created by BumMo Koo on 2020/11/28.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @Environment(\.widgetFamily) var family
    
    func placeholder(in context: Context) -> UpComing2WidgetEntry {
        UpComing2WidgetEntry(date: Date(), events: (Event.events[0], Event.events[1]))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (UpComing2WidgetEntry) -> ()) {
        let entry = UpComing2WidgetEntry(date: Date(), events: (Event.events[0], Event.events[1]))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<UpComing2WidgetEntry>) -> ()) {
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
        var upcomingEvents: (Event?, Event?) = (nil, nil)
        for event in Event.events.enumerated() {
            if Date().timeIntervalSince1970 < event.element.endsAt.timeIntervalSince1970 {
                if event.offset > Event.events.count - 2 {
                    upcomingEvents = (Event.events[event.offset], nil)
                } else {
                    upcomingEvents = (Event.events[event.offset], Event.events[event.offset + 1])
                }
                break
            }
        }
        return upcomingEvents
    }
    
    func getRefreshDate(upcomingEvents: (Event?, Event?)) -> Date? {
        guard let event = upcomingEvents.0 else { return nil }
        return event.endsAt
    }
}
