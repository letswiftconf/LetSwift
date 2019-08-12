//
//  MainTabView.swift
//  LetSwift
//
//  Created by BumMo Koo on 26/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @State private var selected: Tab = .home
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $selected) {
            ForEach(Tab.allCases) { tab in
                tab.presentingView
                    .tabItem { tab.tabItem }
                    .tag(tab)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - Tab
extension MainTabView {
    enum Tab: Int, Identifiable, CaseIterable {
        case home
        case schedule
        case video
        case people
        case settings
        
        // MARK: - Identifiable
        var id: Int {
            return rawValue
        }
        
        // MARK: -
        var presentingView: some View {
            switch self {
            case .home: return AnyView(HomeView())
            case .schedule: return AnyView(ScheduleView())
            case .video: return AnyView(VideoView())
            case .people: return AnyView(PeopleView())
            case .settings: return AnyView(SettingsView())
            }
        }
        
        var tabItem: some View {
            Group {
                Text(name)
                Image(systemName: imageName)
            }
        }
        
        private var name: String {
            switch self {
            case .home: return "Home"
            case .schedule: return "Schedule"
            case .video: return "Video"
            case .people: return "People"
            case .settings: return "Settings"
            }
        }
        
        private var imageName: String {
            switch self {
            case .home: return "house.fill"
            case .schedule: return "calendar"
            case .video: return "film"
            case .people: return "person.fill"
            case .settings: return "gear"
            }
        }
    }
}

#if DEBUG
struct MainTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
#endif
