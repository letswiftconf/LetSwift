//
//  Video.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

// MARK: - Video
/// Video recording of a `Session`.
class Video: Identifiable, Codable, ObservableObject {
    let id = UUID()
    var url: URL { willSet { objectWillChange.send() } }
    var length: TimeInterval { willSet { objectWillChange.send() } }
    
    // MARK: - Initialization
    init(url: URL,
         length: TimeInterval) {
        self.url = url
        self.length = length
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case id, url, length
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
}

// MARK: - Dummy
extension Video {
    static var dummy: Video {
        return Video(url: URL(string: "https://www.youtube.com/watch?v=xZ5IywL9Zkg&list=PLAHa1zfLtLiNPl0RVd6WX6W_aa678RAmS")!,
                     length: 0)
    }
}
