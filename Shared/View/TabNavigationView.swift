//
//  TabNavigationView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct TabNavigationView: View {
    @State private var selected: Tab = .home
    
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
        case home
        case schedule
        case ticket
        case people
        case location
        
        // MARK: Identifiable
        var id: Int {
            return rawValue
        }
        
        // MARK:
        var presentingView: some View {
            switch self {
            case .home: return AnyView(HomeView())
            case .schedule: return AnyView(ScheduleView())
            case .ticket: return AnyView(TicketView())
            case .people: return AnyView(PeopleView())
            case .location: return AnyView(LocationView())
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
            case .home: return "홈"
            case .schedule: return "일정"
            case .ticket: return "티켓"
            case .people: return "사람들"
            case .location: return "장소"
            }
        }
        
        private var imageName: String {
            switch self {
            case .home: return "house.fill"
            case .schedule: return "calendar"
            case .ticket: return "ticket.fill"
            case .people: return "person.fill"
            case .location: return "map.fill"
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
