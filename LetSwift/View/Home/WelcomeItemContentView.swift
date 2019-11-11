//
//  WelcomeItemContentView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/11.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct WelcomeItemContentView: View {
    let emoji: String
    let description1: String
    let description2: String
    let title: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(emoji)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(description1)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(description2)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
        }
        .foregroundColor(.white)
    }
}

// MARK: - Preview
struct WelcomeItemContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeItemContentView(emoji: "💩",
                                   description1: "너무 맛있는 초코와",
                                   description2: "귀여운 눈이 달린",
                                   title: "아이스크림")
        }
        .previewLayout(.sizeThatFits)
    }
}
