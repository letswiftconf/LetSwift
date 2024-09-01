//
//  SettingsView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.openURL) private var openURL
    private var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(Array(viewModel.sections.enumerated()), id: \.offset) { offset, section in
                    VStack(spacing: 1) {
                        ForEach(section.cells) { cell in
                            SettingsCellView(cell: cell) { type in
                                switch type {
                                case .navigate: break
                                case .openUrl(let urlString):
                                    guard let url = URL(string: urlString) else { return }
                                    openURL(url)
                                }
                            }
                        }
                    }
                    .background(.grayStoke)
    
                    if offset != viewModel.numberOfSections - 1 {
                        SettingsSectionDivider()
                    }
                }
            }
        }
        .padding(.top, 1)   // 상단 safe area 영역 벗어나서 컨텐츠가 보이지 않도록 하기 위함
        .background(Color.darkBackground)
        .tabItem {
            Label("settings.title", image: "ic_menu")
        }
        .toolbarBackground(.darkBackground, for: .tabBar)
    }
}

#Preview("Settings(ko)") {
    TabView {
        SettingsView(viewModel: SettingsViewModel())
            .environment(\.locale, Locale(identifier: "ko"))
    }
}

#Preview("Settings(en)") {
    TabView {
        SettingsView(viewModel: SettingsViewModel())
            .environment(\.locale, Locale(identifier: "en"))
    }
}
