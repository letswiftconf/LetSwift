//
//  SubheadlineText.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/01.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SubheadlineText: View {
    private let content: String
    
    // MARK: - Initialization
    init(_ content: String) {
        self.content = content
    }
    
    // MARK: - Body
    var body: some View {
        Text(content)
            .font(.subheadline)
            .foregroundColor(Color(.secondaryLabel))
    }
}

// MARK: - Preview
struct SubheadlineText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SubheadlineText("Let'Swift")
                .previewLayout(.fixed(width: 300, height: 100))
            SubheadlineText("Let'Swift")
                .previewLayout(.fixed(width: 300, height: 100))
                .environment(\.colorScheme, .dark)
            SubheadlineText("Let'Swift")
                .previewLayout(.fixed(width: 300, height: 100))
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
