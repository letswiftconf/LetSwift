//
//  DataStore.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 08/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine
import os.log

class DataStore: ObservableObject {
    static let shared = DataStore()
    
    // MARK: - Property
    @Published private(set) var conferences = [Conference]()
    @Published private(set) var sessions = [Session]()
    @Published private(set) var nonsessions = [NonSession]()
    @Published private(set) var profiles = [Profile]()
    @Published private(set) var participants = [Participant]()
    
    private var fileURL: URL {
        let manager = FileManager.default
        let directory = manager.urls(for: .documentDirectory, in: .userDomainMask).first ?? manager.temporaryDirectory
        return directory.appendingPathComponent("content.json")
    }
    
    // MARK: - Initialization
    private init() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL)
            let content = try decoder.decode(DataFile.self, from: data)
            conferences = content.conferences
            sessions = content.sessions
            nonsessions = content.nonsessions
            profiles = content.profiles
            participants = content.participants
        } catch {
            os_log(.error, log: .default, "%{PUBLIC}@", error.localizedDescription)
        }
    }
    
    // MARK: - Observable Object
//    let objectWillChange = ObservableObjectPublisher()
    
    // MARK: - Action: Save
    func save() {
        let content = DataFile(conferences: conferences,
                               sessions: sessions,
                               nonsessions: nonsessions,
                               profiles: profiles,
                               participants: participants)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(content)
            try data.write(to: fileURL)
        } catch {
            os_log(.error, log: .default, "%{PUBLIC}@", error.localizedDescription)
        }
    }
    
    // MARK: - Action: New
    func addNew(conference: Conference) {
        conferences.append(conference)
    }
    
    func addNew(session: Session) {
        sessions.append(session)
    }
    
    func addNew(nonsession: NonSession) {
        nonsessions.append(nonsession)
    }
    
    func addNew(profile: Profile) {
        profiles.append(profile)
    }
    
    func addNew(participant: Participant) {
        participants.append(participant)
    }
    
    // MARK: - Action: Move
    func moveConference(from source: IndexSet, to destination: Int) {
        conferences.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveSessions(from source: IndexSet, to destination: Int) {
        sessions.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveNonsessions(from source: IndexSet, to destination: Int) {
        nonsessions.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveProfiles(from source: IndexSet, to destination: Int) {
        profiles.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveParticipants(from source: IndexSet, to destination: Int) {
        participants.move(fromOffsets: source, toOffset: destination)
    }
    
    // MARK: - Action: Delete
    func deleteConference(at offsets: IndexSet) {
        conferences.remove(atOffsets: offsets)
    }
    
    func deleteSessions(at offsets: IndexSet) {
        sessions.remove(atOffsets: offsets)
    }
    
    func deleteNonsessions(at offsets: IndexSet) {
        nonsessions.remove(atOffsets: offsets)
    }
    
    func deleteProfiles(at offsets: IndexSet) {
        profiles.remove(atOffsets: offsets)
    }
    
    func deleteParticipants(at offsets: IndexSet) {
        participants.remove(atOffsets: offsets)
    }
}
