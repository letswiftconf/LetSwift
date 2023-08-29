//
//  UndergroundView.swift
//  LetSwift
//
//  Created by Son on 2022/11/17.
//

import SwiftUI

struct UnderLineView : View {
    let isSelected : Bool
    init(isSelected: Bool) {
        self.isSelected = isSelected
    }
    
    var body: some View {
        if isSelected {
            Rectangle()
                .fill(LinearGradient.gradientOrange.opacity(0.45))
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
        } else {
            VStack {
                Spacer()
                Rectangle()
                    .fill(LinearGradient.gradientOrange.opacity(0.45))
                    .frame(width: 73, height: 3)
            }
        }
    }
}
