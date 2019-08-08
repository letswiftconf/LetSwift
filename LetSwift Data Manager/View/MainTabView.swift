//
//  MainTabView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ConferenceListView()
            .tabItem {
                Text("Conferences")
                Image(systemName: "calendar")
            }.tag(0)
            
            SessionListView()
            .tabItem {
                Text("Sessions")
                Image(systemName: "bubble.left.fill")
            }.tag(1)
            
            ProfileListView()
            .tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("Profiles")
            }.tag(2)
            
            ParticipantListView()
            .tabItem {
                Image(systemName: "smiley")
                Text("Participants")
            }.tag(3)
        }
    }
}

struct TabItem: View {
    var body: some View {
        Text("Test")
    }
}

#if DEBUG
struct MainTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
#endif
