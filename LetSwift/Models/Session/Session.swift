//
//  Session.swift
//  LetSwift
//
//  Created by 박진서 on 8/30/24.
//

import Foundation

extension Session {
    var speakerNames: String {
        return self.speakers.map { $0.name }.joined(separator: "&")
    }
}

struct Session: Identifiable, Codable {
    let id: Int
    let title: String
    let track: String
    let speakers: [Speaker]
    let startTime: Date
    let endTime: Date
    
    struct Speaker: Identifiable, Codable {
        var id: String { self.name }
        let name: String
        let profileImage: String
    }
}
