//
//  MainView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/11/24.
//

import SwiftUI

struct MainView: View {
    
    var sessionViewModel: SessionViewModel = SessionViewModel()
    
    var body: some View {
        TabView {
            InformationView()
            SessionView(viewModel: sessionViewModel)
            EventsView()
            MoreView(viewModel: MoreViewModel())
        }
    }
}

#Preview {
    MainView()
}
