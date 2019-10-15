//
//  PeopleList.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/24.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PeopleList: View {
    let title: String
    let speakers: [ProtoSpeaker]
    
    // MARK: - Body
    var body: some View {
        return VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .font(.headline)
                Spacer()
                Button(action: {
                    
                }, label: {
                    Group {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .font(.subheadline)
                })
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(speakers, id: \.self) { speaker in
                        NavigationLink(destination: PersonView()) {
                            SpeakerCell(speaker: speaker)
                                .frame(width: 100, alignment: .top)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Preview
struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        let layout = PreviewLayout.fixed(width: 320, height: 240)
        return Group {
            PeopleList(title: "Section", speakers: ProtoSpeaker.speakers)
                .previewLayout(layout)
            PeopleList(title: "Section", speakers: ProtoSpeaker.speakers)
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            PeopleList(title: "Section", speakers: ProtoSpeaker.speakers)
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
