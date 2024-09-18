//
//  NotificationClickType.swift
//  LetSwift
//
//  Created by Philip Chung on 10/5/24.
//

import Foundation

enum NotificationClickType: Hashable, Codable {
    case none
    case openUrl(url: String)
    
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return [:]
        }
        return dict
    }
}
