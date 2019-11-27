//
//  LevelLegionItem.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/07.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct LevelLegionItem: View {
    let title: String
    let description: String
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ZStack {
                LevelIndicator(level: title, color: Color(.systemGray2), textColor: .white)
                
            }
            Text(description)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview
struct LevelLegionItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LevelLegionItem(title: "초", description: "초급")
            LevelLegionItem(title: "중", description: "중급")
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
