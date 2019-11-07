//
//  LegionSectionView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct LegionSectionView: View {
    // MARK: - Body
    var body: some View {
        Group {
            Divider()
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LegionView()
                    .padding(.horizontal)
            }
            Divider()
                .padding(.horizontal)
        }
    }
}

// MARK: - Preview
struct LegionSectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LegionSectionView()
            LegionSectionView()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
