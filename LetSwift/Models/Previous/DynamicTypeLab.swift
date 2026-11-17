//
//  DynamicTypeLab.swift
//  LetSwift
//
//  TEMP (Dynamic Type lab): screenshot harness for DynamicTypeLab/run.sh.
//  Removed before merging.
//

#if DEBUG
import SwiftUI
import WebKit

/// Picks the screen to show from the environment, so `simctl launch` can open each screen directly.
/// - `DT_LAB_SCREEN`: home | videos | more | detail | appicon
/// - `DT_LAB_WEB_URL`: page the Home tab loads instead of letswift.kr
/// - `DT_LAB_WEB_JS`: JavaScript (a function body) run in the Home page after it loads.
///   Its result is written to Documents/dtlab-web.txt.
/// - `DT_LAB_SCROLL`: 0...1, how far down the screen's scroll view to scroll before the screenshot
@MainActor
enum DynamicTypeLab {
    private static let environment = ProcessInfo.processInfo.environment

    static var screen: String? { environment["DT_LAB_SCREEN"] }
    static var isActive: Bool { screen != nil }
    static var webURL: URL? { environment["DT_LAB_WEB_URL"].flatMap { URL(string: $0) } }

    static var rootView: some View {
        Group {
            switch screen {
            case "videos":
                MainView(selectedTab: .previous)
            case "more":
                MainView(selectedTab: .more)
            case "detail":
                NavigationStack {
                    if let sample = sampleVideo {
                        VideoDetailView(video: sample.video, year: sample.year)
                    }
                }
            case "appicon":
                NavigationStack { AppIconView() }
            default:
                MainView()
            }
        }
        .task { await applyScroll() }
    }

    /// Scrolls every screen-sized scroll view `DT_LAB_SCROLL` of the way down.
    /// Repeated, because list rows are measured lazily.
    private static func applyScroll() async {
        guard let value = environment["DT_LAB_SCROLL"], let fraction = Double(value), fraction > 0 else { return }
        for _ in 0..<3 {
            try? await Task.sleep(for: .seconds(1))
            let windows = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap(\.windows)
            for scrollView in windows.flatMap({ scrollViews(in: $0) }) where scrollView.bounds.height > 300 {
                scrollView.layoutIfNeeded()
                let top = -scrollView.adjustedContentInset.top
                let bottom = scrollView.contentSize.height + scrollView.adjustedContentInset.bottom - scrollView.bounds.height
                guard bottom > top else { continue }
                scrollView.setContentOffset(CGPoint(x: 0, y: top + (bottom - top) * fraction), animated: false)
            }
        }
    }

    private static func scrollViews(in view: UIView) -> [UIScrollView] {
        guard !view.isHidden else { return [] }
        let own = (view as? UIScrollView).map { [$0] } ?? []
        return own + view.subviews.flatMap { scrollViews(in: $0) }
    }

    /// The talk with the longest title that also has a speaker and slides.
    private static var sampleVideo: (video: Video, year: Int)? {
        VideoCatalog.conferences
            .flatMap { conference in conference.videos.map { (video: $0, year: conference.year) } }
            .filter { $0.video.speaker != nil && $0.video.slides != nil }
            .max { $0.video.title.count < $1.video.title.count }
    }

    /// Runs `DT_LAB_WEB_JS` once the page has loaded and settled.
    static func runWebScript(on page: WebPage) async {
        guard isActive else { return }
        // Wait until the page has been loaded and quiet for a second (the site root redirects first).
        var quietChecks = 0
        for _ in 0..<150 where quietChecks < 5 {
            quietChecks = (page.url != nil && !page.isLoading) ? quietChecks + 1 : 0
            try? await Task.sleep(for: .milliseconds(200))
        }
        try? await Task.sleep(for: .seconds(1))
        guard let script = environment["DT_LAB_WEB_JS"], !script.isEmpty else { return }
        let output: String
        do {
            let result = try await page.callJavaScript(script)
            output = result.map { "\($0)" } ?? "null"
        } catch {
            output = "ERROR: \(error)"
        }
        let file = URL.documentsDirectory.appending(path: "dtlab-web.txt")
        try? output.write(to: file, atomically: true, encoding: .utf8)
    }
}
#endif
