//
//  MainView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/11/24.
//

import SwiftUI
import StoreKit

struct MainView: View {
    @Environment(\.requestReview) private var requestReview
    
    @State var selectedTab: Tab = .home

    let sessionViewModel: SessionViewModel = SessionViewModel()
    
    var body: some View {
        if #available(iOS 26, *) {
            mainContent
                .tabBarMinimizeBehavior(.onScrollDown)
                .tabViewStyle(.sidebarAdaptable)
        } else {
            mainContent
        }
    }
    
    private var mainContent: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.self) { tab in
                createTabView(for: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.icon)
                    }
                    .tag(tab)
            }
        }
        .tint(.themePrimary)
        .onAppear {
#if !DEBUG
            requestReview()
#endif
        }
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
            MoreView()
        }
    }
}

#Preview {
    MainView()
}
