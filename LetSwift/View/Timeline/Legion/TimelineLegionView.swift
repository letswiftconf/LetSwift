//
//  TimelineLegionView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct TimelineLegionView: View {
    // MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            TimelineLegionItem(title: "발표", color: Color(.timelineSession))
            TimelineLegionItem(title: "티타임", color: Color(.timelineTeatime))
            TimelineLegionItem(title: "워크샵", color: Color(.timelineWorkshop))
            TimelineLegionItem(title: "기타", color: Color(.timelineEvent))
        }
    }
}

// MARK: - Preview
struct TimelineLegionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimelineLegionView()
            TimelineLegionView()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
