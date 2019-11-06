//
//  AllPeopleList.swift
//  LetSwift
//
//  Created by 김나용 on 15/10/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

struct AllPeopleList: View {
    
    let type: PeopleList.PeopleType
    let people: [SuperPerson]
    
    // MARK: - Body
    var body: some View {
        List(people) { person in
            HStack(alignment: .top, spacing: 16) {
                self.profileView(person)
                self.detailView(person)
            }
            .padding(.vertical)
        }
        .navigationBarTitle(type.title)
    }
    
    // MARK: - Body Builders
    func profileView(_ person: SuperPerson) -> some View {
        return Image(person.name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .mask(Circle())
    }
    
    func detailView(_ person: SuperPerson) -> some View {
        return VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading) {
                    Text(person.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    if !person.organization.isEmpty {
                        Text(person.organization)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                    }
                }
                VStack(alignment: .leading) {
                    Text(person.description)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    if !tags(of: person).isEmpty {
                        Text(tags(of: person))
                            .font(.footnote)
                            .foregroundColor(Color(.tertiaryLabel))
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.vertical)
                    }
                }
                if type == .speakers {
                    sessionView(person)
                }
            }
        }
    }
    
    func sessionView(_ person: SuperPerson) -> AnyView? {
        guard let sessions = (person as? ProtoSpeaker)?.sessions else {
            return nil
        }
        return AnyView(VStack(alignment: .leading, spacing: 4) {
            Text("Sessions")
                .font(.subheadline)
                .bold()
            ForEach(sessions, id: \.description) {
                Text($0)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
        })
    }
    
    // MARK: - Helper
    func tags(of person: SuperPerson) -> String {
        return person.tags.map {"#" + $0 }.joined(separator: " ")
    }
}

// MARK: - Preview
struct AllPeopleList_Previews: PreviewProvider {
    static var previews: some View {
        let layout = PreviewLayout.fixed(width: 320, height: 240)
        return Group {
            AllPeopleList(type: .speakers, people: ProtoSpeaker.speakers)
                .previewLayout(layout)
            AllPeopleList(type: .speakers, people: ProtoSpeaker.speakers)
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            AllPeopleList(type: .speakers, people: ProtoSpeaker.speakers)
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
