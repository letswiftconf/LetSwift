//
//  SettingsView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("settings.writeReview")
            }
            .navigationTitle("settings.title")
        }
        .tabItem {
            Label("settings.title", systemImage: "gear")
        }
    }
}

#Preview {
    TabView {
        SettingsView()
    }
}
