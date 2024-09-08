//
//  MoreView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI
import StoreKit

struct MoreView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.requestReview) private var requestReview
    private var viewModel: MoreViewModel
    
    init(viewModel: MoreViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(Array(viewModel.sections.enumerated()), id: \.offset) { offset, section in
                    VStack(spacing: 1) {
                        ForEach(section.cells) { cell in
                            MoreCellView(cell: cell) { type in
                                switch type {
                                case .navigate: break
                                case .openUrl(let urlString):
                                    guard let url = URL(string: urlString) else { return }
                                    openURL(url)
                                case .requestReview:
                                    requestReview()
                                }
                            }
                        }
                    }
                    .background(.grayStoke)
    
                    if offset != viewModel.numberOfSections - 1 {
                        MoreSectionDivider()
                    }
                }
            }
        }
        .padding(.top, 1)   // 상단 safe area 영역 벗어나서 컨텐츠가 보이지 않도록 하기 위함
        .background(Color.darkBackground)
        .tabItem {
            Label("more.title", image: "ic_menu")
        }
        .toolbarBackground(.darkBackground, for: .tabBar)
    }
}

#Preview("More(ko)") {
    TabView {
        MoreView(viewModel: MoreViewModel())
            .environment(\.locale, Locale(identifier: "ko"))
    }
}

#Preview("More(en)") {
    TabView {
        MoreView(viewModel: MoreViewModel())
            .environment(\.locale, Locale(identifier: "en"))
    }
}
