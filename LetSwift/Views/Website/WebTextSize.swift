//
//  WebTextSize.swift
//  LetSwift
//
//  Created by Claude on 11/17/26.
//

import SwiftUI
import WebKit

/// Makes the text of letswift.kr follow the system text size (Dynamic Type), which web pages don't do by themselves.
///
/// The work is done in the page by `WebTextSize.js`: at the start of every document (as a user script),
/// and again whenever the text size changes. At the default text size nothing is added to the page.
@MainActor
final class WebTextSize {
    /// The sites to resize, as a JavaScript array. Pages of other sites keep their own text sizes.
    private static let hosts = #"["letswift.kr"]"#
    /// The size of body text at the default text size, in points.
    private static let defaultBodySize: CGFloat = 17
    /// How the user script starts, which tells it from the page's other user scripts.
    private static let marker = "/* LetSwift text size */\n"

    /// The function in `WebTextSize.js`.
    private static let function: String? = {
        guard let url = Bundle.main.url(forResource: "WebTextSize", withExtension: "js"),
              let source = try? String(contentsOf: url, encoding: .utf8) else {
            assertionFailure("WebTextSize.js is missing from the app")
            return nil
        }
        return source.trimmingCharacters(in: .whitespacesAndNewlines)
    }()

    private let userContentController: WKUserContentController
    /// How much larger body text is than at the default text size, in points.
    private var extra = 0
    /// Whether a page may hold text that was resized.
    private var hasResized = false

    /// - Parameter userContentController: The one in the configuration of the page to resize.
    init(userContentController: WKUserContentController) {
        self.userContentController = userContentController
    }

    /// Resizes the text of the page that `page` shows, and of every page it loads from now on.
    /// - Parameter bodySize: The size of body text at the current text size:
    ///   17 points, scaled with `@ScaledMetric(relativeTo: .body)`.
    func apply(bodySize: CGFloat, to page: WebPage) {
        // Points are CSS px. Body text has whole sizes: 14 at the smallest text size, 53 at the largest.
        let extra = Int((bodySize - Self.defaultBodySize).rounded())
        guard extra != self.extra else { return }
        self.extra = extra

        // A user script can't be removed by itself, so the page's other user scripts are put back.
        let scripts = userContentController.userScripts
        if scripts.contains(where: { $0.source.hasPrefix(Self.marker) }) {
            userContentController.removeAllUserScripts()
            for script in scripts where !script.source.hasPrefix(Self.marker) {
                userContentController.addUserScript(script)
            }
        }
        if extra != 0, let script = Self.script(extra: extra) {
            userContentController.addUserScript(
                WKUserScript(source: Self.marker + script, injectionTime: .atDocumentStart, forMainFrameOnly: true)
            )
            hasResized = true
        }
        update(page)
    }

    /// Brings the page that `page` shows to the current text size.
    ///
    /// A page loaded from now on does this by itself, but one that was loaded before (the one on screen,
    /// or one that comes back with the back button) still has the size it was loaded with.
    func update(_ page: WebPage) {
        // A page that was never resized has nothing to change, or to undo.
        guard hasResized, page.url != nil, let script = Self.script(extra: extra) else { return }
        Task {
            _ = try? await page.callJavaScript(script)
        }
    }

    /// JavaScript that changes the text of the page it runs in by `extra` points (0 undoes the change).
    private static func script(extra: Int) -> String? {
        function.map { "\($0)(\(extra), \(hosts));" }
    }
}
