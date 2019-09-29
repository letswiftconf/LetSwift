//
//  PersonCell.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/24.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PersonCell: View {
    var name: String
    var userID: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Circle()
                .fill(Color(.tertiarySystemFill))
                .frame(width: 100, height: 100)
            VStack(alignment: .center) {
                Text(name)
                    .font(.body)
                Text(userID)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Spacer()
        }
    }
}

// MARK: - Preview
struct PersonCell_Previews: PreviewProvider {
    static var previews: some View {
        let layout = PreviewLayout.fixed(width: 320, height: 200)
        return Group {
            PersonCell(name: "BumMo", userID: "@gbmksquare")
                .previewLayout(layout)
            PersonCell(name: "BumMo", userID: "@gbmksquare")
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            PersonCell(name: "BumMo", userID: "@gbmksquare")
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
