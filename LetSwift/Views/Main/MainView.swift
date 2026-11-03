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

    var body: some View {
        mainContent
            .tabBarMinimizeBehavior(.onScrollDown)
            .tabViewStyle(.sidebarAdaptable)
    }
    
    private var mainContent: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.tabCases, id: \.self) { item in
                Tab(item.title, systemImage: item.icon, value: item) {
                    switch item {
                    case .website:
                        WebsiteView()
                    case .home:
                        HomeView()
                    case .previous:
                        PreviousView()
                    case .more:
                        MoreView()
                    case .search:
                        EmptyView()
                    }
                }
            }
//            Tab(TabItem.search.title, systemImage: TabItem.search.icon, value: .search, role: .search) {
//                PreviousView()
//            }
        }
        .tint(.themePrimary)
        .onAppear {
#if !DEBUG
            requestReview()
#endif
        }
    }
}

#Preview {
    MainView()
}
