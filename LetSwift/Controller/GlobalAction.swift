//
//  GlobalAction.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/11.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import StoreKit
import os.log

struct GlobalAction {
    // MARK: - Settings
    static func openAppSettings() {
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
    }
    
    // MARK: - App Store
    static func openWriteReivew() {
        let urlString = "itms-apps://apps.apple.com/app/id1282995254?action=write-review"
        let app = UIApplication.shared
        guard let settingsURL = URL(string: urlString),
            app.canOpenURL(settingsURL) else {
                os_log(.error, log: .default, "Failed to open App Store for review")
                return
        }
        app.open(settingsURL, options: [:]) { (didOpen) in
            os_log(.info, log: .default, "Opened App Store for review")
        }
    }
    
    static func requestAppStoreReview() {
        #if !DEBUG
        os_log(.info, log: .default, "Requesting App Store review")
        SKStoreReviewController.requestReview()
        #endif
    }
}
