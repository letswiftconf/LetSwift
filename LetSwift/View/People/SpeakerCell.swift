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
            Image(speaker.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            VStack(alignment: .center) {
                Text(speaker.name)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                Text(speaker.organization)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.secondaryLabel))
            }
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Preview
struct SpeakerCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SpeakerCell(speaker: ProtoSpeaker.speakers.first ?? .dummy)
            SpeakerCell(speaker: ProtoSpeaker.speakers.last ?? .dummy)
                .environment(\.colorScheme, .dark)
            SpeakerCell(speaker: ProtoSpeaker.speakers.first ?? .dummy)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .padding()
        //        .previewLayout(.sizeThatFits)
        .previewLayout(.fixed(width: 100, height: 150))
    }
}
