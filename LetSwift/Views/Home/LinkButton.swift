//
//  LinkButton.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/28.
//

import SwiftUI

struct LinkButton: View {
    @ObservedObject var navigationVM: HomeNavigationViewModel
    var title: String
    var icon: String
    var link: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(icon)
            Text(title)
                .font(.regular(size: 12))
                .foregroundStyle(Color.whiteText)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 75)
        .background(Color.white.opacity(0.02))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        })
        .onTapGesture {
            navigationVM.push(to: .webView(urlString: link))
        }
    }
}

#Preview {
    LinkButton(navigationVM: HomeNavigationViewModel(), title: "뉴스레터", icon: "ic_newsletter", link: "")
}
