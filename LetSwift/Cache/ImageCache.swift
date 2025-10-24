//
//  ImageCache.swift
//  LetSwift
//
//  Created by baabguui on 10/25/25.
//

import SwiftUI
import UIKit

actor ImageCache {
    static let shared = ImageCache()
    private let cache: NSCache<NSURL, UIImage>

    private init() {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
        self.cache = cache
    }

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func insert(_ image: UIImage, for url: URL) {
        let cost: Int
        if let data = image.pngData() {
            cost = data.count
        } else if let data = image.jpegData(compressionQuality: 1.0) {
            cost = data.count
        } else {
            cost = 0
        }
        cache.setObject(image, forKey: url as NSURL, cost: cost)
    }
}

extension ImageCache {
    @MainActor
    static func insert(_ image: UIImage, for url: URL) async {
        await ImageCache.shared.insert(image, for: url)
    }
}
