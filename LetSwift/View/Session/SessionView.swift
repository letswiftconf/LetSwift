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
                return "timetable.tab.savedSession"
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases) { tab in
                    ZStack {
                        Color.darkBackground
                        
                        Text(tab.title)
                            .font(.medium(size: 15))
                            .foregroundStyle(currentTab == tab ? Color.primaryPink : Color.gray5)
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
    }
}

#Preview {
    SessionView()
}
