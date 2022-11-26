//
//  Event.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import Foundation

struct Event: Decodable, Identifiable {
    let id: Int
    let titleImage: String
    let title: String
    let description: String
    let startsAt: Date
    let endsAt: Date
    let isOnAir: Bool
    
    init(id: Int, titleImage: String, title: String, description: String, startsAt: Date, endsAt: Date, date: String, dayOfTheWeek: String, time: String) {
        self.id = id
        self.titleImage = titleImage
        self.title = title
        self.description = description
        self.startsAt = startsAt
        self.endsAt = endsAt
        self.isOnAir = DateManager().judgeSessionNowLive(startsAt: startsAt, endsAt: endsAt)
    }
}

// MARK: - Data
extension Event {
    static let events: [Event] = {
        Bundle.main.loadJSON(fileName: "Event")
    }()
}
