//
//  MainView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/11/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            InformationView()
            EventsView()
            SettingsView()
        }
    }
}

#Preview {
    MainView()
}
