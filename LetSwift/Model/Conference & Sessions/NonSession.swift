//
//  NonSession.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

// MARK: - Non-Session
/// A non-session is a activities between sessions. e.g. Opening Keynote, networking, etc.
class NonSession: Schedulable, Identifiable, Codable, ObservableObject {
    let id = UUID()
    var title: String { willSet { objectWillChange.send() } }
    var description: String { willSet { objectWillChange.send() } }
    var location: String { willSet { objectWillChange.send() } }
    var timespan: DateInterval { willSet { objectWillChange.send() } }
    
    // MARK: - Initialization
    init(title: String,
        description: String,
        location: String,
        timespan: DateInterval) {
        self.title = title
        self.description = description
        self.location = location
        self.timespan = timespan
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case id, title, description, location, timespan
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
}

// MARK: - Dummy
extension NonSession {
    static var dummy: NonSession {
        return NonSession(title: "Untitled",
                          description: "",
                          location: "Unknown Location",
                          timespan: DateInterval())
    }
}
