//
//  PeopleList.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/24.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PeopleList: View {
    var title: String
    var people: [SuperPerson]
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
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
                    ForEach(people, id: \.self) { person in
                        NavigationLink(destination: PersonView(person: person)) {
                            PersonCell(person: person)
                        }.buttonStyle(PlainButtonStyle())
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
        let people = ProtoStaff.makeProtoData()
        return Group {
            PeopleList(title: "Section", people: people)
                .previewLayout(layout)
            PeopleList(title: "Section", people: people)
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            PeopleList(title: "Section", people: people)
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
