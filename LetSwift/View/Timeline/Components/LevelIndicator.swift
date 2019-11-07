//
//  LevelIndicator.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/06.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct LevelIndicator: View {
    let level: String
    var color: Color = Color(#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1))
    let textColor: Color
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
            Text(level)
                .foregroundColor(textColor)
                .font(.system(size: 11))
                .fontWeight(.bold)
        }
        .frame(width: 14, height: 14)
    }
}

// MARK: - Preview
struct LevelIndicator_Previews: PreviewProvider {
    static var previews: some View {
        let color = Color.blue
        return Group {
            LevelIndicator(level: "초", textColor: color)
            LevelIndicator(level: "초", textColor: color)
                .environment(\.colorScheme, .dark)
        }
        .padding()
        .background(color)
        .previewLayout(.sizeThatFits)
    }
}
