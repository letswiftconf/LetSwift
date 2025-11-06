//
//  LetSwift_watchOSApp.swift
//  LetSwift-watchOS Watch App
//
//  Created by BumMo Koo on 10/13/25.
//

import SwiftUI

@main
struct LetSwift_watchOS_Watch_AppApp: App {
    init() {
        // WatchConnectivity 초기화
        _ = WatchConnectivityManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
