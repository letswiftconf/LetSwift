//
//  UndergroundView.swift
//  LetSwift
//
//  Created by Son on 2022/11/17.
//

import SwiftUI


struct UnderLineView : View {
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(LinearGradient.gradientOrange.opacity(0.45))
                .frame(width: 73, height: 3)
        }
    }
}
