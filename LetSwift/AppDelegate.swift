//
//  AppDelegate.swift
//  LetSwift
//
//  Created by Philip Chung on 10/4/24.
//

import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NotificationManager.shared.setDelegate()
        return true
    }
}
