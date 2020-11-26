//
//  LetSwiftApp.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

@main
struct LetSwiftLegacySupportApp {
    static func main() {
        if #available(iOS 14.0, *) {
            LetSwiftApp.main()
        } else {
            UIApplicationMain(CommandLine.argc,
                              CommandLine.unsafeArgv,
                              nil,
                              NSStringFromClass(AppDelegate.self))
        }
    }
}

@available(iOS 14.0, *)
struct LetSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
            letSwiftNotification()
        }
    }
    
    func letSwiftNotification() -> EmptyView {
        UNUserNotificationCenter.requestLetSwiftNotification()
        return EmptyView()
    }
}
