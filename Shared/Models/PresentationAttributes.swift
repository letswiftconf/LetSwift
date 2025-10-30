//
//  PresentationAttributes.swift
//  LetSwift
//
//  Created by 김인환 on 10/24/25.
//

import ActivityKit
import Foundation

/// Speaker information for Live Activity
struct Speaker: Codable, Hashable {
    var name: String
    var profileImage: String?
}

/// Live Activity attributes for presentation tracking
struct PresentationAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var presentationId: Int
        var title: String
        var speakers: [Speaker]
        var location: String?
        var startTime: String
        var endTime: String
        var track: String
        var currentStatus: Status
        
        enum Status: String, Codable, Hashable {
            case upcoming, ongoing, ended, unknown
        }
    }

    var track: String
}
