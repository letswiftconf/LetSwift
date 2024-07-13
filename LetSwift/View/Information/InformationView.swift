//
//  InformationView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 36) {
                    // Banner
                    RoundedRectangle(cornerRadius: 23, style: .continuous)
                        .foregroundStyle(Color(.systemGroupedBackground))
                        .frame(height: 160)
                    SpeakersView()
                    TimeTableView()
                    SponsorsView()
                    PastEventsView()
                }
                .padding(.horizontal)
            }
            .navigationTitle("information.title")
        }
        .tabItem {
            Label("information.title", systemImage: "swift")
        }
    }
}

#Preview {
    TabView {
        InformationView()
    }
}
