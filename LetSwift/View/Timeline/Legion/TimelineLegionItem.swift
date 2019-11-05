//
//  TimelineLegionItem.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct TimelineLegionItem: View {
    let title: String
    let color: Color
    let width: CGFloat = 60
    let height: CGFloat = 8
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            RoundedRectangle(cornerRadius: height / 2, style: .circular)
                .foregroundColor(color)
                .frame(width: width, height: height)
            Text(title)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview
struct TimelineLegionItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimelineLegionItem(title: "세션", color: .blue)
            TimelineLegionItem(title: "세션", color: .blue)
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
