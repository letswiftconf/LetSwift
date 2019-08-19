//
//  Schedule.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

// MARK: - Schedule
/// A list of sessions and non-sessions in an event.
class Schedule: Identifiable, Codable, ObservableObject {
    let id = UUID()
    var sessions: [Session] { willSet { objectWillChange.send() } }
    var nonsessions: [NonSession] { willSet { objectWillChange.send() } }
    
    // MARK: - Initialization
    init(sessions: [Session],
         nonsessions: [NonSession]) {
        self.sessions = sessions
        self.nonsessions = nonsessions
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case id, sessions, nonsessions
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
}

// MARK: - Dummy
extension Schedule {
    static var dummy: Schedule {
        return Schedule(sessions: [],
                        nonsessions: [])
    }
}
