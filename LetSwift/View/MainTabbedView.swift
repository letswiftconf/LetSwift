//
//  MainTabView.swift
//  LetSwift
//
//  Created by BumMo Koo on 26/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct MainTabbedView: View {
    var body: some View {
        TabbedView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
            }
            .tag(0)
            
            ScheduleView()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Schedule")
                    }
            }
            .tag(1)
            
            VideoView()
                .tabItem {
                    VStack {
                        Image(systemName: "film")
                        Text("Video")
                    }
            }
            .tag(2)
            
            PeopleView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("People")
                    }
            }
            .tag(3)
            
            VenueView()
                .tabItem {
                    VStack {
                        Image(systemName: "map.fill")
                        Text("Venue")
                    }
            }
            .tag(4)
            
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .tag(5)
        }
    }
}

#if DEBUG
struct MainTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbedView()
    }
}
#endif
