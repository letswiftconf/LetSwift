//
//  ImageCache.swift
//  LetSwift
//
//  Created by baabguui on 10/25/25.
//

import SwiftUI
import UIKit

final class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
    
    private init() {
        ImageCache.shared.countLimit = 100
        ImageCache.shared.totalCostLimit = 50 * 1024 * 1024
    }
}

extension ImageCache {
    static func insert(_ image: UIImage, for url: URL) {
        let cost: Int
        if let data = image.pngData() {
            cost = data.count
        } else if let data = image.jpegData(compressionQuality: 1.0) {
            cost = data.count
        } else {
            cost = 0
        }
        shared.setObject(image, forKey: url as NSURL, cost: cost)
    }
}
