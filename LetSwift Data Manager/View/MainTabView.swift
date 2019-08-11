//
//  MainTabView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @State private var selected: Tab = .conference
    
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
        case conference
        case session
        case profile
        case participant
        
        // MARK: - Identifiable
        var id: Int {
            return rawValue
        }
        
        // MARK: -
        var presentingView: some View {
            switch self {
            case .conference: return AnyView(ConferenceListView())
            case .session: return AnyView(SessionListView())
            case .profile: return AnyView(ProfileListView())
            case .participant: return AnyView(ParticipantListView())
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
            case .conference: return "Conferences"
            case .session: return "Sessions"
            case .profile: return "Profiles"
            case .participant: return "Participants"
            }
        }
        
        private var imageName: String {
            switch self {
            case .conference: return "chevron.left.slash.chevron.right"
            case .session: return "music.mic"
            case .profile: return "person.fill"
            case .participant: return "person.2.square.stack.fill"
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
