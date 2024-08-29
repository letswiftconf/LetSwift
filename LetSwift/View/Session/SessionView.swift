//
//  SessionView.swift
//  LetSwift
//
//  Created by 박진서 on 8/30/24.
//

import SwiftUI

struct SessionView: View {
    @State private var currentTab: Tab = .trackA
    
    enum Tab: String, Identifiable, CaseIterable {
        var id: String {
            return self.rawValue
        }
        
        case trackA, trackB, savedSession
        
        var title: String {
            switch self {
            case .trackA:
                return "Track A"
            case .trackB:
                return "Track B"
            case .savedSession:
                return NSLocalizedString("timetable.tab.savedSession", comment: "Saved Session tab title")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 0) {
                    ForEach(Tab.allCases) { tab in
                        Button {
                            currentTab = tab
                        } label: {
                            ZStack {
                                Color.darkBackground
                                
                                Text(tab.title)
                                    .font(currentTab == tab ? .medium(size: 15) : .regular(size: 15))
                                    .foregroundStyle(currentTab == tab ? Color.primaryPink : Color.gray5)
                            }
                            .overlay(alignment: .bottom) {
                                if currentTab == tab {
                                    Color.primaryPink
                                        .frame(height: 3)
                                } else {
                                    Color.gray5
                                        .frame(height: 1)
                                }
                            }
                        }
                    }
                }
                .frame(height: 55)
                
                ScrollView {
                    VStack {
                        Spacer()
                    }
                }
            }
            .background(Color.darkBackground)
        }
        .tabItem {
            Label("timetable.title", image: "ic_timetable")
        }
    }
}

#Preview {
    SessionView()
}
