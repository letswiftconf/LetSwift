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
    }
    
    var body: some Scene {
        WindowGroup {
            if InvertLab.isLabScreen { // TEMP (Invert lab)
                InvertLabView(page: InvertLab.mode ?? "lab")
            } else {
            MainView()
                .task {
                    guard InvertLab.mode == nil else { return } // TEMP (Invert lab): no permission alert in screenshots
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
    }
    
    func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        // Keep navigation bar buttons (incl. back button) untinted.
        UINavigationBar.appearance().tintColor = .label
    }
}
