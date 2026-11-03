//
//  WebsiteView.swift
//  LetSwift
//
//  Created by Claude on 11/3/26.
//

import SwiftUI
import WebKit

struct WebsiteView: View {
    @State private var page = WebPage()

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

#Preview {
    WebsiteView()
}
