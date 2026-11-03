//
//  EventViewModel.swift
//  LetSwift-watchOS Watch App
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "kr.codesquad.jk.letswift", category: "EventViewModel")

/// Loads the current Let'Swift event from the site's `.ics` file, with an offline cache.
@MainActor
@Observable
final class EventViewModel {
    private(set) var event: CalendarEvent?
    private(set) var isLoading = false

    private let cacheKey = "cachedEvent-\(LetSwiftEvent.year)"

    init() {
        if let data = UserDefaults.standard.data(forKey: cacheKey) {
            event = try? JSONDecoder().decode(CalendarEvent.self, from: data)
        }
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let (data, response) = try await URLSession.shared.data(from: LetSwiftEvent.calendarURL)
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let ics = String(data: data, encoding: .utf8),
                  let event = CalendarEvent(ics: ics) else {
                logger.error("No event at \(LetSwiftEvent.calendarURL.absoluteString)")
                return
            }
            self.event = event
            if let data = try? JSONEncoder().encode(event) {
                UserDefaults.standard.set(data, forKey: cacheKey)
            }
        } catch {
            logger.error("Failed to load event: \(error.localizedDescription)")
        }
    }
}

extension CalendarEvent {
    enum Status {
        case upcoming(days: Int)
        case today
        case live
        case ended
    }

    func status(at now: Date = .now, calendar: Calendar = .current) -> Status {
        if now >= endDate { return .ended }
        if now >= startDate { return .live }
        let days = calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: now),
            to: calendar.startOfDay(for: startDate)
        ).day ?? 0
        return days == 0 ? .today : .upcoming(days: days)
    }
}
