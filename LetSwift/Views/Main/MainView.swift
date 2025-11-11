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
    
    @State var selectedTab: TabItem = .home

    @State private var sessionViewModel: SessionViewModel = SessionViewModel()

    var body: some View {
        if #available(iOS 26, *) {
            mainContent
                .tabBarMinimizeBehavior(.onScrollDown)
                .tabViewStyle(.sidebarAdaptable)
        } else {
            mainContentPreiOS26
        }
    }
    
    @available(iOS 26, *)
    private var mainContent: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.tabCases, id: \.self) { item in
                Tab(item.title, systemImage: item.icon, value: item) {
                    switch item {
                    case .home:
                        HomeView()
                    case .session:
                        SessionView()
                            .environment(sessionViewModel)
                    case .previous:
                        PreviousView()
                    case .more:
                        MoreView()
                    case .search:
                        SearchTabView()
                            .environment(sessionViewModel)
                    }
                }
            }
        }
        .tint(.themePrimary)
        .onAppear {
#if !DEBUG
            requestReview()
#endif
        }
        .task {
            await sessionViewModel.autoStartLiveActivityIfNeeded()
        }
    }

    private var mainContentPreiOS26: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases, id: \.self) { tab in
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
        .task {
            await sessionViewModel.autoStartLiveActivityIfNeeded()
        }
    }

    @ViewBuilder
    func createTabView(for item: TabItem) -> some View {
        switch item {
        case .home:
            HomeView()
        case .session:
            SessionView()
                .environment(sessionViewModel)
        case .previous:
            PreviousView()
        case .more:
            MoreView()
        case .search:
            SearchTabView()
                .environment(sessionViewModel)
        }
    }
}

#Preview {
    MainView()
}
