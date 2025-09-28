//
//  MainView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/11/24.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab: Tab = .home

    let sessionViewModel: SessionViewModel = SessionViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.self) { tab in
                createTabView(for: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.icon)
                    }
                    .tag(tab)
            }
        }
        .toolbarBackground(.darkBackground, for: .tabBar)
        .onOpenURL { url in
            handleURL(url: url)
        }
        .tint(.primaryPink)
        .environment(\.horizontalSizeClass, .compact)
    }
    
    @ViewBuilder
    func createTabView(for tab: Tab) -> some View {
        switch tab {
        case .home:
            HomeView()
        case .session:
            SessionView(viewModel: sessionViewModel)
        case .previous:
            PreviousView()
        case .more:
            MoreView(viewModel: MoreViewModel())
        }
    }
}

#Preview {
    MainView()
}
