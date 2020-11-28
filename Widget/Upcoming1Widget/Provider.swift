//
//  Provider.swift
//  Upcoming1WidgetExtension
//
//  Created by BumMo Koo on 2020/11/28.
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
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<UpComing1WidgetEntry>) -> ()) {
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
