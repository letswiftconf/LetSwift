//
//  GlobalAction.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/11.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif
import StoreKit
import os.log

struct GlobalAction {
    // MARK: - Settings
    static func openAppSettings() {
        #if os(iOS)
        let urlString = UIApplication.openSettingsURLString
        let app = UIApplication.shared
        guard let settingsURL = URL(string: urlString),
            app.canOpenURL(settingsURL) else {
                os_log(.error, log: .default, "Failed to open application settings")
                return
        }
        app.open(settingsURL, options: [:]) { (didOpen) in
            os_log(.info, log: .default, "Opened application settings")
        }
        #else
        /// https://stackoverflow.com/questions/58330598/is-there-a-way-to-send-the-user-to-the-apps-privacy-settings-under-macos-like-w
        let urlString = "x-apple.systempreferences:com.apple.preference.security"
        guard let settingsURL = URL(string: urlString) else {
            os_log(.error, log: .default, "Failed to open Preferences.app")
            return
        }
        NSWorkspace.shared.open(settingsURL)
        #endif
    }
    
    // MARK: - App Store
    static func openWriteReivew() {
        #if os(iOS)
        let app = UIApplication.shared
        guard app.canOpenURL(.appStoreReview) else {
                os_log(.error, log: .default, "Failed to open App Store for review")
                return
        }
        app.open(.appStoreReview, options: [:]) { (didOpen) in
            os_log(.info, log: .default, "Opened App Store for review")
        }
        #else
        NSWorkspace.shared.open(.appStoreReview)
        #endif
    }
    
    static func requestAppStoreReview() {
        #if !DEBUG
        os_log(.info, log: .default, "Requesting App Store review")
        SKStoreReviewController.requestReview()
        #endif
    }
}
