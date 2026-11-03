//
//  WebsiteView.swift
//  LetSwift
//
//  Created by Claude on 11/3/26.
//

import SwiftUI
import WebKit
import EventKit
import EventKitUI

struct WebsiteView: View {
    @State private var navigationDecider: LinkNavigationDecider
    @State private var page: WebPage

    init() {
        let decider = LinkNavigationDecider()
        let page = WebPage(navigationDecider: decider)
        decider.page = page
        _navigationDecider = State(initialValue: decider)
        _page = State(initialValue: page)
    }

    var body: some View {
        NavigationStack {
            WebView(page)
                .navigationTitle(page.title.isEmpty ? String(localized: "home.title") : page.title)
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("website.back", systemImage: "chevron.backward") {
                            if let item = page.backForwardList.backList.last {
                                page.load(item)
                            }
                        }
                        .disabled(page.backForwardList.backList.isEmpty)
                        .tint(.primary)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if page.isLoading {
                            ProgressView()
                                .tint(.primary)
                        } else {
                            Button("website.reload", systemImage: "arrow.clockwise") {
                                page.reload()
                            }
                            .tint(.primary)
                        }
                    }
                }
        }
        .sheet(item: $navigationDecider.calendarEvent) { item in
            CalendarEventEditor(event: item.event, store: item.store)
                .ignoresSafeArea()
        }
        .onAppear {
            if page.url == nil {
                page.load(URLRequest(url: .letswiftHome))
            }
        }
    }
}

/// Handles links the web view can't show by itself:
/// - `target="_blank"` / `window.open` links on letswift.kr load in the same page.
/// - New-window links to other sites, and non-web schemes (mailto:, tel:, ...), open outside the app.
/// - Calendar links (`.ics`, `data:text/calendar`, `blob:` downloads) open an "Add Event" sheet.
@MainActor
@Observable
private final class LinkNavigationDecider: WebPage.NavigationDeciding {
    @ObservationIgnored weak var page: WebPage?
    var calendarEvent: CalendarEventItem?
    @ObservationIgnored private let eventStore = EKEventStore()

    func decidePolicy(
        for action: WebPage.NavigationAction,
        preferences: inout WebPage.NavigationPreferences
    ) async -> WKNavigationActionPolicy {
        guard let url = action.request.url else { return .allow }

        if isCalendarLink(url, opensInMainFrame: action.target?.isMainFrame ?? true) {
            await presentCalendarEvent(from: url)
            return .cancel
        }

        // Schemes WebKit handles itself (e.g. about:blank / data: / blob: frames used by embeds like Google Maps).
        if ["about", "data", "blob", "javascript"].contains(url.scheme) { return .allow }

        let isWeb = url.scheme == "http" || url.scheme == "https"
        let isLetSwift = url.host()?.hasSuffix("letswift.kr") ?? false
        let opensNewWindow = action.target == nil

        if !isWeb || (opensNewWindow && !isLetSwift) {
            await UIApplication.shared.open(url)
            return .cancel
        }
        if opensNewWindow {
            page?.load(action.request)
            return .cancel
        }
        return .allow
    }

    func decidePolicy(for response: WebPage.NavigationResponse) async -> WKNavigationResponsePolicy {
        if response.response.mimeType == "text/calendar", let url = response.response.url {
            await presentCalendarEvent(from: url)
            return .cancel
        }
        return .allow
    }

    // MARK: - Calendar

    private func isCalendarLink(_ url: URL, opensInMainFrame: Bool) -> Bool {
        switch url.scheme?.lowercased() {
        case "data":
            return url.absoluteString.lowercased().hasPrefix("data:text/calendar")
        case "blob":
            // Only top-level blob navigations (downloads); embeds use blob: subframes.
            return opensInMainFrame
        case "http", "https":
            return url.pathExtension.lowercased() == "ics"
        default:
            return false
        }
    }

    private func presentCalendarEvent(from url: URL) async {
        guard let ics = await calendarText(from: url),
              let event = ICSParser.event(from: ics, store: eventStore) else {
            // Fall back to the system (Safari / Calendar) if we can't read it.
            if url.scheme == "http" || url.scheme == "https" {
                await UIApplication.shared.open(url)
            }
            return
        }
        calendarEvent = CalendarEventItem(event: event, store: eventStore)
    }

    private func calendarText(from url: URL) async -> String? {
        switch url.scheme?.lowercased() {
        case "data":
            return Self.decodeDataURL(url.absoluteString)
        case "blob":
            // Blob URLs only exist inside the page, so read them with JavaScript.
            let script = "const r = await fetch(u); return await r.text();"
            return try? await page?.callJavaScript(script, arguments: ["u": url.absoluteString]) as? String
        default:
            guard let (data, _) = try? await URLSession.shared.data(from: url) else { return nil }
            return String(data: data, encoding: .utf8)
        }
    }

    private static func decodeDataURL(_ string: String) -> String? {
        guard let comma = string.firstIndex(of: ",") else { return nil }
        let header = string[..<comma].lowercased()
        let payload = String(string[string.index(after: comma)...])
        if header.hasSuffix(";base64") {
            guard let data = Data(base64Encoded: payload.removingPercentEncoding ?? payload) else { return nil }
            return String(data: data, encoding: .utf8)
        }
        return payload.removingPercentEncoding
    }
}

private struct CalendarEventItem: Identifiable {
    let id = UUID()
    let event: EKEvent
    let store: EKEventStore
}

/// Shows the system "New Event" editor. No calendar permission is needed for this.
private struct CalendarEventEditor: UIViewControllerRepresentable {
    let event: EKEvent
    let store: EKEventStore
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let controller = EKEventEditViewController()
        controller.eventStore = store
        controller.event = event
        controller.editViewDelegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ controller: EKEventEditViewController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(dismiss: dismiss) }

    final class Coordinator: NSObject, EKEventEditViewDelegate {
        let dismiss: DismissAction
        init(dismiss: DismissAction) { self.dismiss = dismiss }

        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            // UIKit calls this delegate on the main thread.
            let dismiss = dismiss
            MainActor.assumeIsolated { dismiss() }
        }
    }
}

/// Minimal iCalendar (RFC 5545) reader for the first VEVENT.
private enum ICSParser {
    static func event(from ics: String, store: EKEventStore) -> EKEvent? {
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
            let key = String(line[..<colon])
            let value = String(line[line.index(after: colon)...])
            let name = key.split(separator: ";").first.map(String.init)?.uppercased() ?? key
            let params = key.contains(";") ? String(key[key.index(after: key.firstIndex(of: ";")!)...]) : ""
            if fields[name] == nil { fields[name] = (params, value) }
        }

        guard let start = fields["DTSTART"], let startDate = date(start.value, params: start.params) else { return nil }
        let event = EKEvent(eventStore: store)
        event.title = fields["SUMMARY"].map { unescape($0.value) } ?? ""
        event.location = fields["LOCATION"].map { unescape($0.value) }
        event.notes = fields["DESCRIPTION"].map { unescape($0.value) }
        if let url = fields["URL"]?.value { event.url = URL(string: url) }
        event.isAllDay = start.value.count == 8
        event.startDate = startDate
        event.endDate = fields["DTEND"].flatMap { date($0.value, params: $0.params) } ?? startDate.addingTimeInterval(3600)
        return event
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

#Preview {
    WebsiteView()
}
