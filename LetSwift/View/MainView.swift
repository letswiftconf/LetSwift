//
//  MainView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/11/24.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab: Tab = .information
    @State var payload: String = ""

    var sessionViewModel: SessionViewModel = SessionViewModel()
    
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
        .tint(.white)
        .toolbarBackground(.darkBackground, for: .tabBar)
        .onOpenURL { url in
            handleURL(url: url)
        }
    }
    
    @ViewBuilder
    func createTabView(for tab: Tab) -> some View {
        switch tab {
        case .information:
            InformationView()
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

enum Tab: CaseIterable {
    case information
    case session
    case previous
    case events
    case more
    
    var icon: String {
        switch self {
        case .information:
            "ic_home"
        case .session:
            "ic_timetable"
        case .previous:
            "ic_past"
        case .events:
            "ic_event"
        case .more:
            "ic_menu"
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .information:
            "information.title"
        case .session:
            "timetable.title"
        case .previous:
            "previous.title"
        case .events:
            "events.title"
        case .more:
            "more.title"
        }
    }
}
