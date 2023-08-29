//
//  BackgroundView.swift
//  LetSwift
//
//  Created by Son on 2022/11/16.
//

import SwiftUI

struct BackgroundView : View {
    let isCorrected: Bool
    init(isCorrected: Bool) {
        self.isCorrected = isCorrected
    }
    
    var body: some View {
        if isCorrected {
            Rectangle()
                .fill(LinearGradient.gradientOrange.opacity(0.45))
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
        } else {
            Rectangle()
                .fill(Color.backgroundCell.opacity(0.45))
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
        }
        
    }
}
