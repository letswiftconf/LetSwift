//
//  BadgeInfoView.swift
//  LetSwift
//
//  Created by Son on 2022/11/16.
//

import SwiftUI

struct BadgeInfoView : View {
    let titleText = "세션에 참여한 후, 6개 이상의 문제를 풀어보세요 !"
    
    var body: some View {
        HStack(alignment: .center, spacing: 14.0) {
            Image("badge-image")
                .resizable()
                .cornerRadius(12)
                .frame(width: 132.0, height: 132.0)
                
            Text(titleText)
                .font(.bodyRegular)
                .padding(.horizontal, 31.0)
            
            Spacer()
        }
        .padding(.horizontal, 35.0)
    }
}
