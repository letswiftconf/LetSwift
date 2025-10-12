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
        }
        .frame(maxWidth: .infinity)
        .frame(height: 75)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .onTapGesture(perform: onTapGesture)
    }
}

#Preview {
    LinkButton(title: "뉴스레터", icon: "ic_newsletter", onTapGesture: { })
}


#Preview("home") {
    HomeView()
}
