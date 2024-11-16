//
//  MainView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/11/24.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab: Tab = .home
    @State var payload: String = ""

    let sessionViewModel: SessionViewModel = SessionViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.self) { tab in
                createTabView(for: tab)
                    .tabItem {
                        Label(tab.title, image: tab.icon)
                    }
                    .tag(tab)
            }
        }
        .toolbarBackground(.darkBackground, for: .tabBar)
        .onOpenURL { url in
            handleURL(url: url)
        }
        .tint(.white)
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
        case .events:
            EventsView(payload: $payload)
        case .more:
            MoreView(viewModel: MoreViewModel())
        }
    }
    
    private func handleURL(url: URL) {
        let components = URLComponents(string: url.absoluteString)
        
        guard let queryValue = components?.queryItems?.first?.value else { return }
        if components?.path == "/event" {
            self.payload = queryValue
            self.selectedTab = .events
        }
    }
}

#Preview {
    MainView()
}
