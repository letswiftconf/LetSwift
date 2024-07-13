//
//  EventsView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct EventsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    RoundedRectangle(cornerRadius: 23, style: .continuous)
                        .foregroundStyle(Color(.systemGroupedBackground))
                        .frame(height: 200)
                    RoundedRectangle(cornerRadius: 23, style: .continuous)
                        .foregroundStyle(Color(.systemGroupedBackground))
                        .frame(height: 200)
                }
                .padding(.horizontal)
            }
            .navigationTitle("events.title")
        }
        .tabItem {
            Label("events.title", systemImage: "fireworks")
        }
    }
}

#Preview {
    TabView {
        EventsView()
    }
}
