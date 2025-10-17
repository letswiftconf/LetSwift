//
//  HomeView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI
import BetterSafariView

struct HomeView: View {
    @State private var presentURL: URL? = nil
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image("logo_2025_200")
                    .frame(height: 91)
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical, 80)
                
                VStack(spacing: 16) {
                    LocationAndDateView {
                        Task {
                            await open(viewModel.mapUrlScheme)
                        }
                    } onTapCalendarButton: {
                        viewModel.addEvent()
                    }
                    
                    buttonStack
                }
                .padding(.horizontal, 20)
                Spacer()
            }
        }
        .background(Color(.systemGroupedBackground))
        .customAlert($viewModel.alert)
        .safariView(item: $presentURL) { item in
            SafariView(url: item, configuration: .init(entersReaderIfAvailable: false, barCollapsingEnabled: true))
                .preferredControlAccentColor(.themePrimary)
                .dismissButtonStyle(.close)
        }
    }
    
    var buttonStack: some View {
        HStack(spacing: 8) {
            ForEach(viewModel.outlinks) { link in
                LinkButton(title: link.title, icon: link.iconName) {
//                    Task {
//                        await open(link.urlString)
//                    }
                    present(url: link.url)
                }
            }
        }
    }
    
    // MARK: - Action
    private func present(url: URL?) {
        guard let url = url else {
            return
        }
        presentURL = url
    }
    
    private func open(_ urlString: String) async -> Bool {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            return await UIApplication.shared.open(url)
        }
        
        return false
    }
}

#Preview {
    TabView {
        HomeView()
    }
    .environment(\.locale, .init(identifier: "ko"))
}
