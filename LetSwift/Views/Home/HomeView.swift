//
//  HomeView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Image("banner1")
                .frame(height: 91)
                .aspectRatio(contentMode: .fit)
                .padding(.vertical, 53)
            
            VStack(spacing: 16) {
                LocationAndDateView()
                buttonStack
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .background(.darkBackground)
    }
    
    var buttonStack: some View {
        HStack(spacing: 16) {
            LinkButton(title: "뉴스레터 구독", icon: "ic_newsletter") {
                open(Constants.URL.newsletterSubscribeURL)
            }
            LinkButton(title: "홈페이지", icon: "ic_homepage") {
                open(Constants.URL.eventURL)
            }
            LinkButton(title: "페스타", icon: "ic_festa") {
                open(Constants.URL.festaURL)
            }
        }
    }
    
    
    func open(_ urlString: String) {
        Task {
            if let url = URL(string: urlString) {
                await UIApplication.shared.open(url)
            }
        }
    }
}

#Preview {
    TabView {
        HomeView()
    }
    .environment(\.locale, .init(identifier: "ko"))
}
