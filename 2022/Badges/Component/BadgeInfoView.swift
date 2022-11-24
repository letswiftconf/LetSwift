//
//  BadgeInfoView.swift
//  LetSwift
//
//  Created by Son on 2022/11/16.
//

import SwiftUI

struct BadgeInfoView : View {
    let hasBadge : Bool
    init(hasBadge: Bool) {
        self.hasBadge = hasBadge
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 14.0) {
            Image(hasBadge ? "badge-image" : "badge-none")
                .resizable()
                .cornerRadius(12)
                .frame(width: 132.0, height: 132.0)
                
            Text(hasBadge ? "🎉🎉🎉🎉\nLet's play at\nSwift Playgrounds" : "세션에 참여한 후, 6개 이상의 문제를 풀어보세요 !")
                .truncationMode(.tail)
                .font(.bodyRegular)
                .padding(.horizontal, 31.0)
            
            Spacer()
        }
        .padding(.horizontal, 35.0)
    }
}
