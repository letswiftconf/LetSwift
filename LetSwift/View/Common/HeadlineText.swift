//
//  HeadlineText.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/01.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct HeadlineText: View {
    private let content: String
    
    // MARK: - Initialization
    init(_ content: String) {
        self.content = content
    }
    
    // MARK: - Body
    var body: some View {
        Text(content)
            .font(.headline)
    }
}

// MARK: - Preview
struct HeadlineText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeadlineText("Let'Swift")
                .previewLayout(.fixed(width: 300, height: 100))
            HeadlineText("Let'Swift")
                .previewLayout(.fixed(width: 300, height: 100))
                .environment(\.colorScheme, .dark)
            HeadlineText("Let'Swift")
                .previewLayout(.fixed(width: 300, height: 100))
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
