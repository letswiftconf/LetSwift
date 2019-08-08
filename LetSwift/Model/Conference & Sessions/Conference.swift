//
//  Conference.swift
//  LetSwift
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

// MARK: - Conference
/// A developer conference. e.g. Let'Swift 2019.
class Conference: Identifiable, Codable, ObservableObject {
    let id = UUID()
    var title: String { willSet { objectWillChange.send() } }
    var description: String { willSet { objectWillChange.send() } }
    var date: Date { willSet { objectWillChange.send() } }
    
    var schedule: Schedule { willSet { objectWillChange.send() } }
    var participants: [Participant] { willSet { objectWillChange.send() } }
    
    // MARK: - Initialization
    init(title: String,
         description: String,
         date: Date,
         schedule: Schedule,
         participants: [Participant]) {
        self.title = title
        self.description = description
        self.date = date
        self.schedule = schedule
        self.participants = participants
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case id, title, description, date, schedule, participants
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
}
