//
//  InformationView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct InformationView: View {
    @StateObject private var navigationVM: HomeNavigationViewModel = HomeNavigationViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationVM.presentedRoutes) {
            ZStack {
                Color.darkBackground
                    .ignoresSafeArea(edges: .all)
                ScrollView {
                    // Banner
                    Image("banner1")
                        .frame(height: 91)
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical, 53)
                    
                    VStack(spacing: 16) {
                        LocationAndDateView()
                        buttonStack
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case .sample: SampleView()
                case .webView(let urlString): WebView(urlToload: urlString)
                }
            }
        }
    }
    
    var buttonStack: some View {
        HStack(spacing: 16) {
            LinkButton(navigationVM: navigationVM, title: "뉴스레터 구독", icon: "ic_newsletter", link: Constants.URL.newsletterSubscribeURL)
            LinkButton(navigationVM: navigationVM, title: "홈페이지", icon: "ic_homepage", link: Constants.URL.eventURL)
            LinkButton(navigationVM: navigationVM, title: "페스타", icon: "ic_festa", link: Constants.URL.festaURL)
        }
        
    }
    
}

#Preview {
    TabView {
        InformationView()
    }
    .environment(\.locale, .init(identifier: "ko"))
}
