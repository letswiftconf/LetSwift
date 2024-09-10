//
//  NotificationManager.swift
//  LetSwift
//
//  Created by Philip Chung on 9/10/24.
//

import Foundation
import UserNotifications

final class NotificationManager: NSObject {
    static let shared = NotificationManager()
    
    func setup() {
        Task {
            let notificationCenter = UNUserNotificationCenter.current()
            let _ = try? await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
            UNUserNotificationCenter.current().delegate = self
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate {
    // For Foreground Notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.list, .banner, .sound, .badge]
    }
}
