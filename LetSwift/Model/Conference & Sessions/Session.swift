//
//  Session.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

// MARK: - Session
/// A session represents a presentation by a `Speaker`.
class Session: Schedulable, Identifiable, Codable, ObservableObject {
    let id = UUID()
    var title: String { willSet { objectWillChange.send() } }
    var description: String { willSet { objectWillChange.send() } }
    var speaker: Participant { willSet { objectWillChange.send() } }
    var location: String { willSet { objectWillChange.send() } }
    var timespan: DateInterval { willSet { objectWillChange.send() } }
    var track: Session.Track { willSet { objectWillChange.send() } }
    var video: Video? { willSet { objectWillChange.send() } }
    
    // MARK: - Initialization
    init(title: String,
         description: String,
         speaker: Participant,
         location: String,
         timespan: DateInterval,
         track: Session.Track,
         video: Video?) {
        self.title = title
        self.description = description
        self.speaker = speaker
        self.location = location
        self.timespan = timespan
        self.track = track
        self.video = video
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case id, title, description, speaker, location, timespan, track, video
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
}

// MARK: - Equatable & Hashable
extension Session: Hashable {
    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Track
extension Session {
    /// Track type of a `Session`. e.g. A session can be either `.sesssion` track or `.workshop` track.
    enum Track: String, Identifiable, Codable, CaseIterable {
        case unspecified
        case session
        case workshop
        
        var id: String {
            return rawValue
        }
        
        var localizedName: String {
            switch self {
            case .unspecified: return "Unspecified"
            case .session: return "Session"
            case .workshop: return "Workshop"
            }
        }
    }
}

// MARK - Dummy
extension Session {
    static var dummy: Session {
        return Session(title: "Untitled",
                       description: "",
                       speaker: Participant.dummy,
                       location: "Unknown Location",
                       timespan: DateInterval(),
                       track: .unspecified,
                       video: nil)
    }
}
