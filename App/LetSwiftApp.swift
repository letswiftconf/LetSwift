//
//  LetSwiftApp.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI
import UserNotifications

@main
struct LetSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .accentColor(.white)
                .onAppear {
                    UNUserNotificationCenter.requestLetSwiftNotification()
                    APICaller.shared.getAllProfileData()
                }
                .preferredColorScheme(ColorScheme.dark)
        }
    }
}
