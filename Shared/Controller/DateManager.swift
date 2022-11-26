//
//  DateManager.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import Foundation

struct DateManager {
    static func isPassAvailable() -> Bool {
        let today = Calendar.current.dateComponents([.year, .month,  .day], from: Date())
        if today.year != 2020 {
            return false
        }
        guard let day = today.day else {
            return false
        }
        if today.month == 11 {
            if day > 23 && day <= 30 {
                return true
            }
        }
        if today.month == 12 {
            if day < 5 {
                return true
            }
        }
        return false
    }
    
    func judgeSessionNowLive(startsAt: Date, endsAt: Date) -> Bool {
        let today = Calendar.current.dateComponents([.month, .day, .hour], from: Date())
        let sessionStart = Calendar.current.dateComponents([.month, .day, .hour], from: startsAt)
        let sessionEnd = Calendar.current.dateComponents([.month, .day, .hour], from: endsAt)
        
        guard today.month == sessionStart.month && today.day == sessionStart.day else { return false }
        guard let startHour = sessionStart.hour,
              let endHour = sessionEnd.hour,
              let nowHour = today.hour
        else { return false }
        guard startHour <= nowHour, nowHour <= endHour else { return false }
        
        return true
    }
}
