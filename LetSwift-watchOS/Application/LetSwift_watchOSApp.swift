//
//  LetSwift_watchOSApp.swift
//  LetSwift-watchOS Watch App
//
//  Created by BumMo Koo on 10/13/25.
//

import SwiftUI

@main
struct LetSwift_watchOS_Watch_AppApp: App {
#if DEBUG
    // TEMP (Dynamic Type lab)
    init() {
        DynamicTypeLab.prepare()
    }
#endif

    var body: some Scene {
        WindowGroup {
#if DEBUG
            // TEMP (Dynamic Type lab)
            if DynamicTypeLab.isActive {
                DynamicTypeLab.rootView
            } else {
                ContentView()
            }
#else
            ContentView()
#endif
        }
    }
}
