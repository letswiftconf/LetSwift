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
    @discardableResult
    func createNewConference() -> Conference {
        let conference = Conference(title: "Let\'Swift",
                                    description: "",
                                    date: Date(),
                                    schedule: Schedule(sessions: [],
                                                       nonsessions: []),
                                    participants: [])
        conferences.append(conference)
        objectWillChange.send()
        return conference
    }
    
    @discardableResult
    func createNewProfile() -> Profile {
        let profile = Profile(familyName: "Appleseed",
                              givenName: "John")
        profiles.append(profile)
        objectWillChange.send()
        return profile
    }
    
    @discardableResult
    func createNewParticipant() -> Participant {
        let placeholderProfile = Profile(familyName: "Appleseed",
                                         givenName: "John")
        let participant = Participant(profile: placeholderProfile,
                                      role: .unspecified,
                                      description: "",
                                      imageUrlString: "",
                                      socialAccounts: [])
        participants.append(participant)
        objectWillChange.send()
        return participant
    }
    
    func addNew(session: Session) {
        sessions.append(session)
    }
}
