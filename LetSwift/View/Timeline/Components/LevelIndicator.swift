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
    let color: Color
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)))
            Text(level)
                .foregroundColor(color)
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
            LevelIndicator(level: "초", color: color)
            LevelIndicator(level: "초", color: color)
                .environment(\.colorScheme, .dark)
        }
        .padding()
        .background(color)
        .previewLayout(.sizeThatFits)
    }
}
