//
//  NotificationManager.swift
//  LetSwift
//
//  Created by Philip Chung on 9/10/24.
//

import Foundation
@preconcurrency import UserNotifications
import UIKit
import ActivityKit

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
        let userInfo = notification.request.content.userInfo

        // Check for Live Activity events
        if #available(iOS 17.2, *) {
            if let aps = userInfo["aps"] as? [String: Any],
               let event = aps["event"] as? String {
                switch event {
                case "update":
                    await handleLiveActivityUpdate(from: aps)
                case "end":
                    await handleLiveActivityEnd(from: aps)
                default:
                    break
                }
            }
        }

        return [.list, .banner, .sound, .badge]
    }

    nonisolated func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo

        // Handle Live Activity events
        if #available(iOS 17.2, *) {
            if let aps = userInfo["aps"] as? [String: Any],
               let event = aps["event"] as? String {
                switch event {
                case "start":
                    await LiveActivityLauncher.shared.startLiveActivityIfNeeded(from: userInfo)
                case "update":
                    await handleLiveActivityUpdate(from: aps)
                case "end":
                    await handleLiveActivityEnd(from: aps)
                default:
                    break
                }
            }
        }

        // Handle other notification actions
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

    // MARK: - Live Activity Helpers

    @available(iOS 17.2, *)
    nonisolated(nonsending)
    private func handleLiveActivityUpdate(from aps: [String: Any]) async {
        guard let contentStateDict = aps["content-state"] as? [String: Any],
              let track = contentStateDict["track"] as? String else {
            return
        }

        // Find the matching activity
        let activities = Activity<PresentationAttributes>.activities
        guard let activity = activities.first(where: { $0.attributes.track == track }) else {
            return
        }

        do {
            // Parse the new content state
            let contentStateData = try JSONSerialization.data(withJSONObject: contentStateDict)
            let newContentState = try JSONDecoder().decode(PresentationAttributes.ContentState.self, from: contentStateData)

            // Update the activity
            let updatedContent = ActivityContent(state: newContentState, staleDate: nil)
            await activity.update(updatedContent)
        } catch {
            // Silent failure
        }
    }

    @available(iOS 17.2, *)
    nonisolated(nonsending)
    private func handleLiveActivityEnd(from aps: [String: Any]) async {
        guard let contentStateDict = aps["content-state"] as? [String: Any],
              let track = contentStateDict["track"] as? String else {
            return
        }

        // Find the matching activity
        let activities = Activity<PresentationAttributes>.activities
        guard let activity = activities.first(where: { $0.attributes.track == track }) else {
            return
        }

        do {
            // Parse the final content state
            let contentStateData = try JSONSerialization.data(withJSONObject: contentStateDict)
            let finalContentState = try JSONDecoder().decode(PresentationAttributes.ContentState.self, from: contentStateData)

            // End the activity with final state
            let finalContent = ActivityContent(state: finalContentState, staleDate: nil)
            await activity.end(finalContent, dismissalPolicy: .default)
        } catch {
            // Silent failure
        }
    }
}

