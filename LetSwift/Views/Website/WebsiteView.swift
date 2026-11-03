//
//  WebsiteView.swift
//  LetSwift
//
//  Created by Claude on 11/3/26.
//

import SwiftUI
import WebKit

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
@MainActor
private final class LinkNavigationDecider: WebPage.NavigationDeciding {
    weak var page: WebPage?

    func decidePolicy(
        for action: WebPage.NavigationAction,
        preferences: inout WebPage.NavigationPreferences
    ) async -> WKNavigationActionPolicy {
        guard let url = action.request.url else { return .allow }

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
}

#Preview {
    WebsiteView()
}
