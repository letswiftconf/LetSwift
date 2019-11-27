//
//  HomeHeroView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct HomeHeroView: View {
    // MARK: - Body
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("Logo_Background"))
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical, 30)
        }
        .frame(height: 220)
        .modifier(RoundedMask())
    }
}

// MARK: - Preview
struct HomeHeroView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeHeroView()
            HomeHeroView()
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
