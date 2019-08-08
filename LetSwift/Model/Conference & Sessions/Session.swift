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
class Session: Schedulable, Identifiable, Codable {
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

// MARK: - Track
/// Track type of a `Session`. e.g. A session can be either `.sesssion` track or `.workshop` track.
extension Session {
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
