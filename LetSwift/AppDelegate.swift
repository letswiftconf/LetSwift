//
//  AppDelegate.swift
//  LetSwift
//
//  Created by Philip Chung on 10/4/24.
//

import UIKit
import FirebaseCore
import UserNotifications
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Task {
            await NotificationManager.shared.setDelegate()
        }
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initializeApp(application)
        return true
    }

    private func initializeApp(_ application: UIApplication) {
        FirebaseApp.configure()

        // 앱 실행 시 사용자에게 알림 허용 권한을 받음
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )

        // UNUserNotificationCenterDelegate를 구현한 메서드를 실행시킴
        application.registerForRemoteNotifications()

        // 파이어베이스 Meesaging 설정
        Messaging.messaging().delegate = self

        // Start observing Live Activity push-to-start token
        if #available(iOS 17.2, *) {
            LiveActivityTokenManager.shared.observePushToStartToken()
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate {
    nonisolated func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        // Store FCM token in UserDefaults
        if let token = fcmToken {
            UserDefaults.standard.set(token, forKey: "fcmToken")

            // Register tokens with server
            if #available(iOS 17.2, *) {
                Task {
                    await LiveActivityTokenManager.shared.registerTokensWithServer()
                }
            }
        }
    }
}
