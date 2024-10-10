//
//  SessionModel.swift
//  LetSwift
//
//  Created by Philip Chung on 9/18/24.
//

import Foundation

@Observable class SessionModel {
    let identifier: String
    let name: String
    let speaker: Session.Speaker?
    let track: String
    let trackEn: String
    let startTime: Date
    let endTime: Date
    
    var isSaved: Bool = false
    var isAlarmed: Bool = false
    
    init(from session: Session) {
        self.identifier = session.id
        self.name = session.name
        self.speaker = session.speaker
        self.track = session.track
        self.trackEn = session.trackEn
        self.startTime = session.startTime
        self.endTime = session.endTime
    }
}

extension SessionModel {
    @ObservationIgnored
    var alarmBeginNotificationIdentifier: String {
        "\(self.identifier)_start"
    }
    
    @ObservationIgnored
    var alarmEndNotificationIdentifier: String {
        "\(self.identifier)_end"
    }
    
    @ObservationIgnored
    var alarmNotificationIdentifiers: [String] {
        return [
            self.alarmBeginNotificationIdentifier,
            self.alarmEndNotificationIdentifier
        ]
    }
}
