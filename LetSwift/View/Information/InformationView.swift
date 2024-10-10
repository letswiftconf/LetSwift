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
            LinkButton(navigationVM: navigationVM, title: "뉴스레터 구독", icon: "ic_newsletter", link: "https://page.stibee.com/subscriptions/58654")
            LinkButton(navigationVM: navigationVM, title: "홈페이지", icon: "ic_homepage", link: "https://letswift.kr/2024/")
            // 아직까지 작년 페스타로 올해 페스타 나오면 업데이트 필요
            LinkButton(navigationVM: navigationVM, title: "페스타", icon: "ic_festa", link: "https://festa.io/events/3860")
        }
        
    }
    
}

#Preview {
    TabView {
        InformationView()
    }
    .environment(\.locale, .init(identifier: "ko"))
}
