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
    @Published var conferences = [Conference]()
    @Published var profiles = [Profile]()
    @Published var participants = [Participant]()
    
    // MARK: - Initialization
    private init() {
        
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
    
    // MARK: - Action
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
                                      imageUrl: nil,
                                      socialAccounts: [])
        participants.append(participant)
        objectWillChange.send()
        return participant
    }
}
