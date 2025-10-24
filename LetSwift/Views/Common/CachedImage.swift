//
//  CachedAsyncImage.swift
//  LetSwift
//
//  Created by baabguui on 10/25/25.
//

import SwiftUI

struct CachedImage<Content: View, Placeholder: View>: View {
    let url: URL
    let content: (Image) -> Content
    let placeholder: () -> Placeholder

    @State private var cachedImage: UIImage?
    @State private var isLoading = false

    init(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let cachedImage {
                content(Image(uiImage: cachedImage))
            } else if isLoading {
                placeholder()
            } else {
                placeholder()
            }
        }
        .onAppear {
            loadFromCache()
            if cachedImage == nil && !isLoading {
                Task { await loadOrFetch() }
            }
        }
    }

    private func loadFromCache() {
        if let cached = ImageCache.shared.object(forKey: url as NSURL) {
            cachedImage = cached
        }
    }

    @MainActor
    private func setImageAndCache(_ image: UIImage, dataSize: Int) {
        ImageCache.insert(image, for: url)
        cachedImage = image
    }

    private func loadOrFetch() async {
        if cachedImage != nil { return }
        await MainActor.run { isLoading = true }
        defer { Task { await MainActor.run { isLoading = false } } }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                await MainActor.run {
                    setImageAndCache(uiImage, dataSize: data.count)
                }
            }
        } catch { }
    }
}
