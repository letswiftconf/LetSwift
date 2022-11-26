//
//  Provider.swift
//  ScheduleWidgetExtension
//
//  Created by BumMo Koo on 2020/11/28.
//

import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ScheduleWidgetEntry {
        ScheduleWidgetEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ScheduleWidgetEntry) -> ()) {
        let entry = ScheduleWidgetEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ScheduleWidgetEntry>) -> ()) {
        let timeline = Timeline(entries: [ScheduleWidgetEntry(date: Date())], policy: .never)
        completion(timeline)
    }
}
