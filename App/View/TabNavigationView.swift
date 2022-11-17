//
//  TabNavigationView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct TabNavigationView: View {
    @State private var selected: Tab = .sessions
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $selected) {
            ForEach(Tab.allCases) { tab in
                NavigationView {
                    tab.presentingView
                }
                .tabItem { tab.tabItem }
                .tag(tab)
            }
        }
    }
}

// MARK: - Tab model
extension TabNavigationView {
    enum Tab: Int, Identifiable, CaseIterable {
        case sessions
        case badges
        case playgrounds
        case settings
//        case location
        
        // MARK: Identifiable
        var id: Int {
            return rawValue
        }
        
        // MARK:
        var presentingView: some View {
            switch self {
            case .sessions: return AnyView(HomeView())
            case .badges: return AnyView(ScheduleView())
            case .playgrounds:
                return AnyView(GuestBookContainerView().environmentObject(GuestBookEnviromentOjb()))
            case .settings: return AnyView(SettingMainView())
//            case .location: return AnyView(LocationView())
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
            case .sessions: return "세션"
            case .badges: return "뱃지"
            case .playgrounds: return "놀이터"
            case .settings: return "설정"
//            case .location: return "장소"
            }
        }
        
        private var imageName: String {
            switch self {
            case .sessions: return "calendar"
            case .badges: return "ticket.fill"
            case .playgrounds: return "gamecontroller.fill"
            case .settings: return "gearshape.fill"
//            case .location: return "map.fill"
            }
        }
    }
}

// MARK: - Preview
struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
            .previewAsScreen()
    }
}
