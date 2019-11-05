//
//  TimelineLegionSection.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct TimelineLegionSection: View {
    // MARK: - Body
    var body: some View {
        Group {
            Divider()
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                TimelineLegionView()
                    .padding(.horizontal)
            }
            Divider()
                .padding(.horizontal)
        }
    }
}

// MARK: - Preview
struct TimelineLegionSection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimelineLegionSection()
            TimelineLegionSection()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
