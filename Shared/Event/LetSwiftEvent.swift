//
//  LetSwiftEvent.swift
//  LetSwift
//

import Foundation

/// Where the apps find the current Let'Swift event.
/// Update `year` each year. letswift.kr publishes the event as an `.ics` file,
/// and a session timetable only when the event has one.
enum LetSwiftEvent {
    static let year = 2026

    static let websiteURL = URL(string: "https://letswift.kr/\(year)/")!
    static let calendarURL = URL(string: "https://letswift.kr/\(year)/letswift-\(year).ics")!
    static let scheduleURL = URL(string: "https://letswift.kr/\(year)/assets/json/schedule.json")!
}

/// An event read from an iCalendar (`.ics`) file.
struct CalendarEvent: Codable, Hashable, Sendable {
    var title: String
    var startDate: Date
    var endDate: Date
    var location: String?
    var notes: String?
    var url: URL?
    var isAllDay: Bool

    /// Reads the first `VEVENT` of an iCalendar (RFC 5545) document.
    init?(ics: String) {
        // Unfold continuation lines (lines starting with a space or tab).
        let unfolded = ics
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\n ", with: "")
            .replacingOccurrences(of: "\n\t", with: "")

        var inEvent = false
        var fields: [String: (params: String, value: String)] = [:]
        for line in unfolded.split(separator: "\n").map(String.init) {
            if line == "BEGIN:VEVENT" { inEvent = true; continue }
            if line == "END:VEVENT" { break }
            guard inEvent, let colon = line.firstIndex(of: ":") else { continue }
            let key = line[..<colon]
            let value = String(line[line.index(after: colon)...])
            let parts = key.split(separator: ";", maxSplits: 1)
            let name = parts[0].uppercased()
            let params = parts.count > 1 ? String(parts[1]) : ""
            if fields[name] == nil { fields[name] = (params, value) }
        }

        guard let start = fields["DTSTART"],
              let startDate = Self.date(start.value, params: start.params) else { return nil }

        self.title = fields["SUMMARY"].map { Self.unescape($0.value) } ?? ""
        self.startDate = startDate
        self.endDate = fields["DTEND"].flatMap { Self.date($0.value, params: $0.params) }
            ?? startDate.addingTimeInterval(3600)
        self.location = fields["LOCATION"].map { Self.unescape($0.value) }
        self.notes = fields["DESCRIPTION"].map { Self.unescape($0.value) }
        self.url = fields["URL"].flatMap { URL(string: $0.value) }
        self.isAllDay = start.value.count == 8
    }

    private static func date(_ value: String, params: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if value.count == 8 {
            formatter.dateFormat = "yyyyMMdd"
            formatter.timeZone = .current
            return formatter.date(from: value)
        }
        if value.hasSuffix("Z") {
            formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
            formatter.timeZone = TimeZone(identifier: "UTC")
        } else {
            formatter.dateFormat = "yyyyMMdd'T'HHmmss"
            let tzid = params.split(separator: ";")
                .first { $0.uppercased().hasPrefix("TZID=") }
                .map { String($0.dropFirst(5)) }
            formatter.timeZone = tzid.flatMap(TimeZone.init(identifier:)) ?? .current
        }
        return formatter.date(from: value)
    }

    private static func unescape(_ text: String) -> String {
        text.replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\N", with: "\n")
            .replacingOccurrences(of: "\\,", with: ",")
            .replacingOccurrences(of: "\\;", with: ";")
            .replacingOccurrences(of: "\\\\", with: "\\")
    }
}

/// Where an event is relative to now, by calendar day.
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
