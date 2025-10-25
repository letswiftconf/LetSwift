//
//  NotificationManager.swift
//  LetSwift
//
//  Created by Philip Chung on 9/10/24.
//

import Foundation
@preconcurrency import UserNotifications
import UIKit

actor NotificationManager: NSObject {
    static let shared = NotificationManager()
    
    func setDelegate() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuthorization() async {
        let notificationCenter = UNUserNotificationCenter.current()
        let _ = try? await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
    }
    
    func registerNotification(_ notificationRequest: NotificationRequest) async throws {
        let content = UNMutableNotificationContent()
        content.body = notificationRequest.body
        
        if let clickType = notificationRequest.clickType {
            content.userInfo = [
                Constants.Notification.clickTypeUserInfoKey: clickType.dictionary
            ]
        }
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: notificationRequest.sendDate.dateComponent,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: notificationRequest.identifier,
            content: content,
            trigger: trigger
        )
        
        try await UNUserNotificationCenter.current().add(request)
    }
    
    func isAuthorized() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus == .authorized
    }
    
    func removeNotification(identifiers: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate {
    // For Foreground Notification
    nonisolated func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.list, .banner, .sound, .badge]
    }
    
    nonisolated func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        
        if let clickType = userInfo[Constants.Notification.clickTypeUserInfoKey] as? [String: Any],
           let jsonData = try? JSONSerialization.data(withJSONObject: clickType),
           let notificationType = try? JSONDecoder().decode(NotificationClickType.self, from: jsonData) {
            switch notificationType {
            case .none:
                break
            case .openUrl(let urlString):
                guard let url = URL(string: urlString) else { return }
                await MainActor.run {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}

