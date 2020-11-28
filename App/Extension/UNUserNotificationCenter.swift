//
//  UNUserNotificationCenter.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/25.
//

import UIKit

typealias UserNotificationInfo = (title: String, message: String, date: String)

extension UNUserNotificationCenter {
    static func makeUserNotification() -> [UserNotificationInfo] {
        return [
            UserNotificationInfo("환영합니다!", "오늘부터 금요일까지 진행될 레츠스위프트 2020, 준비되셨나요?", "2020-11-30T12:00:00+09:00"),
            UserNotificationInfo("준비하세요!", "\"스위프트, 오픈소스, CoreML\" 세션이 곧 시작됩니다.", "2020-11-30T18:50:00+09:00"),
            UserNotificationInfo("준비하세요!", "\"SwiftUI vs UIKit 끝장토론\" 세션이 곧 시작됩니다.", "2020-12-01T18:50:00+09:00"),
            UserNotificationInfo("준비하세요!", "\"XCode, 패키지 관리, 빌드환경\" 세션이 곧 시작됩니다.", "2020-12-02T18:50:00+09:00"),
            UserNotificationInfo("준비하세요!", "\"아키텍처, 테스트, 배포\" 세션이 곧 시작됩니다.", "2020-12-03T18:50:00+09:00"),
            UserNotificationInfo("준비하세요!", "\"개발문화, 코드리뷰, 기술블로그\" 세션이 곧 시작됩니다.", "2020-12-04T18:50:00+09:00"),
            UserNotificationInfo("이제 안녕!", "레츠스위프트 2020 함께 해주셔서 감사합니다!", "2020-12-04T22:10:00+09:00")
        ]
    }
    
    static func requestLetSwiftNotification() {
        guard UserDefaults.standard.value(forKey: "isWillNotify") == nil || UserDefaults.standard.value(forKey: "isWillNotify") as? Bool == false else { return }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                UNUserNotificationCenter.makeUserNotification().forEach { info in
                    let content = UNMutableNotificationContent()
                    content.subtitle = info.title
                    content.body = info.message
                    content.sound = UNNotificationSound.default
                    
                    let formatter = ISO8601DateFormatter()
                    let date = formatter.date(from: info.date)!
                    let localizedDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: localizedDate, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                    
                    UserDefaults.standard.setValue(true, forKey: "isWillNotify")
                }
            }
        }
    }
}
