//
//  SpeakerCell.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/14.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SpeakerCell: View {
    var name: String
    var userID: String = ""
    var organization: String = ""
    var sessionTitle  = ""
    var tags: [String] = []
    var description: String = ""
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image("Sample")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .mask(Circle())
            VStack(alignment: .center) {
                Text(name)
                    .font(.body)
                    .fontWeight(.bold)
                Text(organization)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.secondaryLabel))
                Text(userID)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                Text(sessionTitle)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                //                tags.reduce("") { tag in
                //                    Text(tag + " ")
                //                        .font(.footnote)
                //                        .foregroundColor(Color(.secondaryLabel))
                //                }
                Text(description)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Spacer()
        }
    }
}

// MARK: - Preview
struct SpeakerCell_Previews: PreviewProvider {
    static var previews: some View {
        let layout = PreviewLayout.fixed(width: 320, height: 200)
        return Group {
            SpeakerCell(name: "BumMo",
                        sessionTitle: "How to Kill a Mockingbird")
                .previewLayout(layout)
            SpeakerCell(name: "BumMo",
                        userID: "@gbmksquare",
                        sessionTitle: "How to Kill a Mockingbird")
                .previewLayout(layout)
            SpeakerCell(name: "BumMo",
                        userID: "@gbmksquare",
                        organization: "Korea Univ",
                        sessionTitle: "How to Kill a Mockingbird")
                .previewLayout(layout)
            SpeakerCell(name: "BumMo",
                        organization: "Korea Univ",
                        sessionTitle: "How to Kill a Mockingbird")
                .previewLayout(layout)
            SpeakerCell(name: "BumMo",
                        userID: "@gbmksquare",
                        organization: "Korea Univ",
                        sessionTitle: "How to Kill a Mockingbird",
                        description: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros.")
                .previewLayout(layout)
            SpeakerCell(name: "BumMo",
                        userID: "@gbmksquare",
                        organization: "Korea Univ",
                        sessionTitle: "How to Kill a Mockingbird",
                        description: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros.")
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            SpeakerCell(name: "BumMo",
                        userID: "@gbmksquare",
                        organization: "Korea Univ",
                        sessionTitle: "How to Kill a Mockingbird",
                        description: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros.")
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
