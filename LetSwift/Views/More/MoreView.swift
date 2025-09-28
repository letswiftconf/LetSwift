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
        NavigationView {
            List {
                ForEach(Array(viewModel.sections.enumerated()), id: \.offset) { offset, section in
                    Section {
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
                }
            }
            .navigationTitle("more.title")
            .background(Color.darkBackground)
        }
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
