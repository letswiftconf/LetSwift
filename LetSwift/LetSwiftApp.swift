//
//  LetSwiftApp.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/11/24.
//

import SwiftUI

@main
struct LetSwiftApp: App {
    
    init() {
        setTabBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(resource: .darkBackground)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
