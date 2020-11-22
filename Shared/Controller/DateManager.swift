//
//  DateManager.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import Foundation

struct DateManager {
    func judgeSessionNowLive(date: String, time: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        guard let formattedDate = dateFormatter.date(from: "2020년 \(date)")?.addingTimeInterval(32400) else { return false }
        let today = Calendar.current.dateComponents([.month, .day, .hour], from: Date())
        let sessionDay = Calendar.current.dateComponents([.month, .day], from: formattedDate)
        guard today.month == sessionDay.month && today.day == sessionDay.day else { return false }
        
        
        let startTime = time[time.startIndex...time.index(time.startIndex, offsetBy: 4)]
        let endTime = time[time.index(time.endIndex, offsetBy: -5)...time.index(before: time.endIndex)]
        dateFormatter.dateFormat = "HH:mm"
        let start = dateFormatter.date(from: String(startTime))!
        let end = dateFormatter.date(from: String(endTime))!
        
        let s = Calendar.current.dateComponents([.hour], from: start)
        let e = Calendar.current.dateComponents([.hour], from: end)
        
        guard let startHour = s.hour, let endHour = e.hour, let nowHour = today.hour else { return false }
        guard startHour <= nowHour, nowHour <= endHour else { return false }
        
        return true
    }
}
