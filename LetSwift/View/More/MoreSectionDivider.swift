//
//  MoreSectionDivider.swift
//  LetSwift
//
//  Created by Philip Chung on 9/2/24.
//

import SwiftUI

struct MoreSectionDivider: View {
    private let height: CGFloat
    
    init(height: CGFloat = 10) {
        self.height = height
    }
    
    var body: some View {
        Color.grayStoke
            .frame(maxWidth: .infinity)
            .frame(height: height)
    }
}

#Preview {
    MoreSectionDivider()
}
