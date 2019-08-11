//
//  DataStore.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 08/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

class DataStore: ObservableObject {
    static let shared = DataStore()
    
    // MARK: - Property
    @Published private(set) var conferences = [Conference]()
    @Published private(set) var sessions = [Session]()
    @Published private(set) var profiles = [Profile]()
    @Published private(set) var participants = [Participant]()
    
    // MARK: - Initialization
    private init() {
        
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
    
    // MARK: - Action: New
    func addNew(conference: Conference) {
        conferences.append(conference)
    }
    
    func addNew(session: Session) {
        sessions.append(session)
    }
    
    func addNew(profile: Profile) {
        profiles.append(profile)
    }
    
    func addNew(participant: Participant) {
        participants.append(participant)
    }
}
