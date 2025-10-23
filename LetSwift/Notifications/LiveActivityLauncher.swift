//
//  LiveActivityLauncher.swift
//  LetSwift
//
//  Created by 김인환 on 10/24/25.
//

import Foundation
import ActivityKit
import UIKit

@available(iOS 17.2, *)
final class LiveActivityLauncher: Sendable {
    static let shared = LiveActivityLauncher()

    private init() {}

    /// Start Live Activity from notification payload when app is opened from terminated state
    func startLiveActivityIfNeeded(from userInfo: [AnyHashable: Any]) async {
        // Check if this is a Live Activity notification
        guard let aps = userInfo["aps"] as? [String: Any],
              let event = aps["event"] as? String,
              event == "start",
              let contentStateDict = aps["content-state"] as? [String: Any],
              let attributesDict = aps["attributes"] as? [String: Any] else {
            return
        }

        do {
            // Parse content state
            let contentStateData = try JSONSerialization.data(withJSONObject: contentStateDict)
            let contentState = try JSONDecoder().decode(PresentationAttributes.ContentState.self, from: contentStateData)

            // Parse attributes
            let attributesData = try JSONSerialization.data(withJSONObject: attributesDict)
            let attributes = try JSONDecoder().decode(PresentationAttributes.self, from: attributesData)

            // Check if activity already exists
            let existingActivities = Activity<PresentationAttributes>.activities
            let alreadyExists = existingActivities.contains { $0.attributes.track == attributes.track }

            if alreadyExists {
                return
            }

            // Create and start Live Activity
            let content = ActivityContent(state: contentState, staleDate: nil)
            let activity = try Activity.request(
                attributes: attributes,
                content: content,
                pushType: .token
            )

            // Observe token for this activity
            await LiveActivityTokenManager.shared.observeActivityToken(activity)

        } catch {}
    }
}
