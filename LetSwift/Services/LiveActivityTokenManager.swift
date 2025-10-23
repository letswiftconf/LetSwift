//
//  LiveActivityTokenManager.swift
//  LetSwift
//
//  Created by 김인환 on 10/23/25.
//

import Foundation
import ActivityKit
import UIKit

/// Manager for handling Live Activity tokens and registration
@available(iOS 17.2, *)
actor LiveActivityTokenManager {

    static let shared = LiveActivityTokenManager()

    private var pushToStartTokenTask: Task<Void, Never>?
    private var activityMonitorTask: Task<Void, Never>?
    private var activityTokenTasks: [String: Task<Void, Never>] = [:]

    private init() {}

    /// Start observing push-to-start token
    func observePushToStartToken() {
        pushToStartTokenTask?.cancel()

        pushToStartTokenTask = Task {
            // Request push-to-start token for PresentationAttributes
            for await data in Activity<PresentationAttributes>.pushToStartTokenUpdates {
                let token = data.map { String(format: "%02x", $0) }.joined()
                print("📱 Push-to-start token received: \(token)")

                // Store token
                UserDefaults.standard.set(token, forKey: "pushToStartToken")

                // Register with server
                await registerTokensWithServer()
            }
        }

        // Also monitor for any active activities
        monitorActiveActivities()
    }

    /// Monitor active Live Activities and observe their tokens
    private func monitorActiveActivities() {
        activityMonitorTask?.cancel()

        activityMonitorTask = Task {
            for await activity in Activity<PresentationAttributes>.activityUpdates {
                // When a new activity starts (from push-to-start or manually), observe its token
                print("📱 New activity detected: \(activity.id)")
                observeActivityToken(activity)
            }
        }
    }

    /// Start observing active Live Activity token
    /// - Parameter activity: The activity to observe
    func observeActivityToken(_ activity: Activity<PresentationAttributes>) {
        let track = activity.attributes.track

        // Cancel existing task for this track if any
        activityTokenTasks[track]?.cancel()

        activityTokenTasks[track] = Task {
            for await data in activity.pushTokenUpdates {
                let token = data.map { String(format: "%02x", $0) }.joined()
                print("📱 Live Activity token received for track \(track): \(token)")

                // Store token with track
                var tokens = getLiveActivityTokens()
                tokens[track] = token
                saveLiveActivityTokens(tokens)

                // Register with server
                await registerTokensWithServer()
            }
        }
    }

    /// Get all Live Activity tokens from UserDefaults
    private func getLiveActivityTokens() -> [String: String] {
        guard let data = UserDefaults.standard.data(forKey: "liveActivityTokens"),
              let tokens = try? JSONDecoder().decode([String: String].self, from: data) else {
            return [:]
        }
        return tokens
    }

    /// Save Live Activity tokens to UserDefaults
    private func saveLiveActivityTokens(_ tokens: [String: String]) {
        if let data = try? JSONEncoder().encode(tokens) {
            UserDefaults.standard.set(data, forKey: "liveActivityTokens")
        }
    }

    /// Register all available tokens with the server
    func registerTokensWithServer() async {
        print("\n📤 ========== REGISTERING TOKENS WITH SERVER ==========")

        // Get device ID (using identifierForVendor)
        guard let deviceId = await UIDevice.current.identifierForVendor?.uuidString else {
            print("❌ Failed to get device ID")
            return
        }
        print("✅ Device ID: \(deviceId)")

        // Get FCM token
        guard let fcmToken = UserDefaults.standard.string(forKey: "fcmToken") else {
            print("❌ FCM token not available yet")
            return
        }
        print("✅ FCM Token: \(fcmToken.prefix(40))...")

        // Get optional tokens
        let pushToStartToken = UserDefaults.standard.string(forKey: "pushToStartToken")
        let liveActivityTokens = getLiveActivityTokens()

        if let token = pushToStartToken {
            print("✅ Push-to-Start Token: \(token.prefix(40))...")
        } else {
            print("⚠️  Push-to-Start Token: NOT SET")
        }

        if !liveActivityTokens.isEmpty {
            print("✅ Live Activity Tokens:")
            for (track, token) in liveActivityTokens {
                print("   Track \(track): \(token.prefix(40))...")
            }
        } else {
            print("ℹ️  Live Activity Tokens: NOT SET (will be available after first activity starts)")
        }

        // Get app version
        let appVersion = Bundle.appVersion

        // Create request
        let request = DeviceRegistrationRequest(
            deviceId: deviceId,
            fcmToken: fcmToken,
            pushToStartToken: pushToStartToken,
            liveActivityTokens: liveActivityTokens.isEmpty ? nil : liveActivityTokens,
            appVersion: appVersion,
            platform: "iOS"
        )

        print("\n📡 Sending registration request to server...")
        print("   pushToStartToken: \(pushToStartToken ?? "nil")")
        print("   liveActivityTokens: \(liveActivityTokens.count) token(s)")

        do {
            let response = try await DeviceRegistrationService.shared.registerDevice(request)
            print("✅ Device registered successfully!")
            print("   Server response: \(response.message)")
            print("======================================================\n")
        } catch {
            print("❌ Failed to register device: \(error.localizedDescription)")
            print("======================================================\n")
        }
    }

    /// Cancel all token observation tasks
    func cancelObservation() {
        pushToStartTokenTask?.cancel()
        activityMonitorTask?.cancel()
        activityTokenTasks.values.forEach { $0.cancel() }
        activityTokenTasks.removeAll()
    }

    deinit {
        pushToStartTokenTask?.cancel()
        activityMonitorTask?.cancel()
        activityTokenTasks.values.forEach { $0.cancel() }
    }
}
