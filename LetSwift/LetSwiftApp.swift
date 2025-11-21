//
//  LetSwiftApp.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/11/24.
//

import SwiftUI

@main
struct LetSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        setTabBarAppearance()
        // WatchConnectivity 초기화
        _ = WatchConnectivityManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .task {
                    await NotificationManager.shared.requestAuthorization()
                    if Date.now < NotificationRequest.conferenceClosingNotification.sendDate {
                        try? await NotificationManager.shared.registerNotification(NotificationRequest.conferenceClosingNotification)
                    }
                }
                .task {
                    _ = FeatureFlagController.shared
                }
        }
    }
    
    func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
