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
    var link: String
    
    var body: some View {
        VStack {
            Image("ic_bell")
            Text(title)
                .font(.regular(size: 12))
                .foregroundStyle(Color.grayIcon)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 75)
        .background(Color.grayRec)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onTapGesture {
            navigationVM.push(to: .webView(urlString: link))
        }
    }
}

#Preview {
    LinkButton(navigationVM: HomeNavigationViewModel(), title: "뉴스레터", link: "")
}
