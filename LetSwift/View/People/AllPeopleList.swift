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
            NavigationLink(destination: ProfileDetailView(type: self.type, person: person)) {
                HStack(alignment: .top, spacing: 16) {
                    ProfileImageView(imageName: person.name)
                        .frame(width: 80, height: 80)
                    self.detailView(person)
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitle(type.title)
        .onAppear {
            GlobalAction.requestAppStoreReview()
        }
    }
    
    // MARK: - View components
    func detailView(_ person: SuperPerson) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Name & Organization
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
            // Description
            Text(person.description)
                .font(.footnote)
            // Tag
            if !person.tags.isEmpty {
                HStack {
                    Text(person.tags.map {"#" + $0 }.joined(separator: " "))
                        .font(.caption)
                        .foregroundColor(Color(.tertiaryLabel))
                }
            }
            // Session
//            if type == .speakers {
//                sessionView(person)
//            }
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
}

// MARK: - Preview
struct AllPeopleList_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            NavigationView {
                AllPeopleList(type: .speakers, people: ProtoSpeaker.speakers)
            }
            NavigationView {
                AllPeopleList(type: .speakers, people: ProtoSpeaker.speakers)
            }
            .environment(\.colorScheme, .dark)
            NavigationView {
                AllPeopleList(type: .speakers, people: ProtoSpeaker.speakers)
            }
            .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
