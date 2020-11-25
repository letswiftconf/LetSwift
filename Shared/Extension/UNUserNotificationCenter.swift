//
//  UNUserNotificationCenter.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/25.
//

import UIKit

typealias UserNotificationInfo = (title: String, message: String, month: Int, day: Int,  hour: Int, minute: Int)

extension UNUserNotificationCenter {
    static func requestLetSwiftNotification() {
        guard UserDefaults.standard.value(forKey: "isWillNotify") == nil || UserDefaults.standard.value(forKey: "isWillNotify") as? Bool == false else { return }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                DateManager.makeUserNotification().forEach { info in
                    let content = UNMutableNotificationContent()
                    content.subtitle = info.title
                    content.body = info.message
                    content.sound = UNNotificationSound.default
                    
                    let formatter = DateFormatter.KSTDateFormatter(by: "yyyy-MM-dd HH:mm:ss")
                    guard let date = formatter.date(from: "2020-\(info.month)-\(info.day) \(info.hour):\(info.minute):00") else { return }
                
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
