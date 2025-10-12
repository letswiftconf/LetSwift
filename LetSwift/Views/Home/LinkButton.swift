//
//  LinkButton.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/28.
//

import SwiftUI

struct LinkButton: View {
    
    var title: String
    var icon: String
    var onTapGesture: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Image(icon)
            Text(title)
                .font(.system(size: 12))
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 75)
        .background(Color.white.opacity(0.02))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        })
        .onTapGesture(perform: onTapGesture)
    }
}

#Preview {
    LinkButton(title: "뉴스레터", icon: "ic_newsletter", onTapGesture: { })
}
