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
            MainView()
                .task {
                    await NotificationManager.shared.requestAuthorization()
                    if Date.now < NotificationRequest.conferenceClosingNotification.sendDate {
                        try? await NotificationManager.shared.registerNotification(NotificationRequest.conferenceClosingNotification)
                    }
                }
        }
    }
    
    func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(resource: .background1)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
