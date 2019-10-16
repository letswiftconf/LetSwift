//
//  SpeakerCell.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/14.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SpeakerCell: View {
    var name: String = ""
    var userID: String = ""
    var organization: String = ""
    var sessionTitle  = ""
    var tags: [String] = []
    var description: String = ""
    
    let speaker: ProtoSpeaker
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Image("Sample")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            VStack(alignment: .center) {
                Text(speaker.name)
                    .font(.body)
                    .fontWeight(.bold)
                Text(speaker.organization)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.secondaryLabel))
                Text(speaker.subDescription)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(2)
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
            SpeakerCell(speaker: ProtoSpeaker.speakers.first ?? .dummy)
                .previewLayout(layout)
            SpeakerCell(speaker: ProtoSpeaker.speakers.last ?? .dummy)
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            SpeakerCell(speaker: ProtoSpeaker.speakers.first ?? .dummy)
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
