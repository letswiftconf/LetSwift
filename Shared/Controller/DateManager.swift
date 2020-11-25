//
//  DateManager.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import Foundation

struct DateManager {
    func judgeSessionNowLive(date: String, time: String) -> Bool {
        guard let sessionTime = stringDateConvert(date: date, time: time) else { return false }
        
        let today = Calendar.current.dateComponents([.month, .day, .hour], from: Date())
        let sessionStart = Calendar.current.dateComponents([.month, .day, .hour], from: sessionTime.start)
        let sessionEnd = Calendar.current.dateComponents([.month, .day, .hour], from: sessionTime.end)
        
        guard today.month == sessionStart.month && today.day == sessionStart.day else { return false }
        guard let startHour = sessionStart.hour,
              let endHour = sessionEnd.hour,
              let nowHour = today.hour
        else { return false }
        guard startHour <= nowHour, nowHour <= endHour else { return false }
        
        return true
    }
    
    func stringDateConvert(date: String, time: String) -> (start: Date, end: Date)? {
        let dateFormatter = DateFormatter.KSTDateFormatter(by: "yyyy년 MM월 dd일 HH:mm")
        
        let startTime = time[time.startIndex...time.index(time.startIndex, offsetBy: 4)]
        let endTime = time[time.index(time.endIndex, offsetBy: -5)...time.index(before: time.endIndex)]
        
        guard let startDate = dateFormatter.date(from: "2020년 \(date) \(startTime)"),
              let endDate = dateFormatter.date(from: "2020년 \(date) \(endTime)")
        else { return nil }
        
        return (startDate, endDate)
    }
}

extension DateManager {
    static func makeUserNotification() -> [UserNotificationInfo] {
        return [
            UserNotificationInfo("Welcome!", "오늘부터 금요일까지 진행될 레츠스위프트, 준비되셨나요?", 11, 30, 0, 0),
            UserNotificationInfo("준비하세요!", "\"스위프트, 오픈소스, CoreML\" 세션이 곧 시작됩니다.", 11, 30, 18, 50),
            UserNotificationInfo("준비하세요!", "\"SwiftUI vs UIKit 끝장토론\" 세션이 곧 시작됩니다.", 12, 1, 18, 50),
            UserNotificationInfo("준비하세요!", "\"XCode, 패키지 관리, 빌드환경\" 세션이 곧 시작됩니다.", 12, 2, 18, 50),
            UserNotificationInfo("준비하세요!", "\"아키텍처, 테스트, 배포\" 세션이 곧 시작됩니다.", 12, 3, 18, 50),
            UserNotificationInfo("준비하세요!", "\"개발문화, 코드리뷰, 기술블로그\" 세션이 곧 시작됩니다.", 12, 4, 18, 50),
            UserNotificationInfo("GoodBye!", "오늘이 2020 레츠스위프트의 마지막 날입니다. 함께해 주실 거죠?", 12, 4, 0, 0)
        ]
    }
}
