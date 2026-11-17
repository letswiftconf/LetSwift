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
    @State private var pageColors: PageColorsMonitor
    @State private var page: WebPage

    init() {
        let decider = LinkNavigationDecider()
        let pageColors = PageColorsMonitor()
        let configuration = WebPage.Configuration()
        if InvertLab.mode != "web-off" { // TEMP (Invert lab): "web-off" is the page without Smart Invert handling
            pageColors.install(in: configuration.userContentController)
        }
        let page = WebPage(configuration: configuration, navigationDecider: decider)
        decider.page = page
        _navigationDecider = State(initialValue: decider)
        _pageColors = State(initialValue: pageColors)
        _page = State(initialValue: page)
    }

    var body: some View {
        NavigationStack {
            WebView(page)
                // Smart Invert reverses a light page, as it does in Safari. A page that is already dark,
                // such as letswift.kr, keeps its own colors instead of turning into a bright negative.
                .accessibilityIgnoresInvertColors(pageColors.pageIsDark)
                .overlay(alignment: .bottomLeading) { // TEMP (Invert lab): shows the reported state on screenshots
                    if let mode = InvertLab.mode {
                        Text(verbatim: "\(mode) | pageIsDark=\(pageColors.pageIsDark)")
                            .font(.caption2.monospaced())
                            .padding(4)
                            .background(.yellow)
                            .foregroundStyle(.black)
                    }
                }
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
        .task { // TEMP (Invert lab): "web-tour" goes from the dark Home page to a light page and back
            guard InvertLab.mode == "web-tour" else { return }
            try? await Task.sleep(for: .seconds(16))
            page.load(URLRequest(url: URL(string: "https://en.wikipedia.org/wiki/Swift_(programming_language)")!))
            try? await Task.sleep(for: .seconds(12))
            if let item = page.backForwardList.backList.last {
                page.load(item)
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
              let parsed = CalendarEvent(ics: ics) else {
            // Fall back to the system (Safari / Calendar) if we can't read it.
            if url.scheme == "http" || url.scheme == "https" {
                await UIApplication.shared.open(url)
            }
            return
        }
        let event = EKEvent(eventStore: eventStore)
        event.title = parsed.title
        event.startDate = parsed.startDate
        event.endDate = parsed.endDate
        event.isAllDay = parsed.isAllDay
        event.location = parsed.location
        event.notes = parsed.notes
        event.url = parsed.url
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

/// Smart Invert support for the web view. The app shows a dark page un-inverted and lets a light page invert,
/// so a script in the page reports which of the two it is. The same script stops WebKit from re-inverting
/// images and video on a page that is shown un-inverted: WebKit does that whenever Smart Invert is on,
/// because it expects the whole web view to be inverted.
@MainActor
@Observable
private final class PageColorsMonitor: NSObject, WKScriptMessageHandler {
    private(set) var pageIsDark = false

    func install(in controller: WKUserContentController) {
        controller.addUserScript(WKUserScript(source: Self.script, injectionTime: .atDocumentStart, forMainFrameOnly: false))
        controller.add(self, name: "letswiftPageColors")
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.frameInfo.isMainFrame, let isDark = message.body as? Bool else { return }
        pageIsDark = isDark
    }

    private static let script = """
        (() => {
            // WebKit re-inverts images and video so that Smart Invert leaves them alone. On a page the app
            // shows un-inverted that would turn them into negatives, so this sheet switches the re-inversion off.
            const sheet = new CSSStyleSheet();
            sheet.replaceSync("@media (inverted-colors: inverted) { :where(img:not(picture > img), picture, video) { filter: none; } }");
            sheet.disabled = true;
            document.adoptedStyleSheets = [...document.adoptedStyleSheets, sheet];

            // Whether the app shows this page un-inverted. Frames inside the page follow their parent.
            let kept = false;
            const keep = value => {
                kept = value;
                sheet.disabled = !value;
                for (let index = 0; index < frames.length; index++) {
                    frames[index].postMessage({ letswiftKeepsColors: value }, "*");
                }
            };
            addEventListener("message", event => {
                const data = event.data;
                if (!data || typeof data !== "object") return;
                if (data.letswiftAsksColors === true && event.source) {
                    // From a frame that loaded after the last change.
                    event.source.postMessage({ letswiftKeepsColors: kept }, "*");
                } else if (typeof data.letswiftKeepsColors === "boolean" && self !== top && event.source === parent) {
                    keep(data.letswiftKeepsColors);
                }
            });
            if (self !== top) {
                parent.postMessage({ letswiftAsksColors: true }, "*");
                return;
            }

            // Main frame only from here: work out whether the page is dark, and tell the app.

            // Relative luminance of a CSS color, or null if it is transparent. Painting one pixel reads any color syntax.
            const canvas = document.createElement("canvas");
            canvas.width = canvas.height = 1;
            const pixel = canvas.getContext("2d", { willReadFrequently: true });
            const luminance = color => {
                pixel.clearRect(0, 0, 1, 1);
                pixel.fillStyle = "transparent";
                pixel.fillStyle = color;
                pixel.fillRect(0, 0, 1, 1);
                const [red, green, blue, alpha] = pixel.getImageData(0, 0, 1, 1).data;
                if (alpha < 128) return null;
                const linear = value => {
                    const channel = value / 255;
                    return channel <= 0.04045 ? channel / 12.92 : ((channel + 0.055) / 1.055) ** 2.4;
                };
                return 0.2126 * linear(red) + 0.7152 * linear(green) + 0.0722 * linear(blue);
            };

            // The page background is the color html paints, or else body. Dark means white text reads better on it
            // than black text does. null: neither paints a color (yet).
            const paintsDarkBackground = () => {
                for (const element of [document.documentElement, document.body]) {
                    const value = element ? luminance(getComputedStyle(element).backgroundColor) : null;
                    if (value !== null) return value < 0.18;
                }
                return null;
            };

            let reported = null;
            const report = isDark => {
                if (isDark !== kept) keep(isDark);
                if (isDark !== reported) {
                    reported = isDark;
                    webkit.messageHandlers.letswiftPageColors.postMessage(isDark);
                }
            };

            // While the page loads, report its background as soon as it is known, so that a dark page does not
            // flash inverted. Until then the app keeps showing the web view the way it did for the last page.
            const watch = () => {
                const isDark = paintsDarkBackground();
                if (isDark !== null) report(isDark);
                if (document.readyState !== "complete") requestAnimationFrame(watch);
            };
            watch();

            // A page that paints no background is a light one: the default is white. That is only certain
            // once its style sheets have loaded.
            const settle = () => report(paintsDarkBackground() ?? false);
            addEventListener("DOMContentLoaded", () => {
                const sheetsLoaded = [...document.querySelectorAll("link[rel~=stylesheet i]")].every(link => link.sheet);
                if (sheetsLoaded) settle();
            });
            addEventListener("load", settle);
            // Shown again from the back-forward cache: by now the app may have another page's answer.
            addEventListener("pageshow", event => {
                if (!event.persisted) return;
                reported = null;
                settle();
            });
        })();
        """
}

#Preview {
    WebsiteView()
}
