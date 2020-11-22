//
//  Event.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import Foundation

struct Event {
    let titleImage: String
    let title: String
    let description: String
    let date: String
    let dayOfTheWeek: String
    let time: String
    let isOnAir: Bool
    let dateManager = DateManager()
    
    init(titleImage: String, title: String, description: String, date: String, dayOfTheWeek: String, time: String) {
        self.titleImage = titleImage
        self.title = title
        self.description = description
        self.date = date
        self.dayOfTheWeek = dayOfTheWeek
        self.time = time
        self.isOnAir = dateManager.judgeSessionNowLive(date: date, time: time)
    }
}
