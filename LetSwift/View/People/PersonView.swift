//
//  PersonView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/24.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PersonView: View {
    
    let type: PeopleList.PeopleType
    var person: SuperPerson
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                profileView()
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(person.description)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                        if !tags(of: person).isEmpty {
                            Text(tags(of: person))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    if type == .speakers {
                        Divider()
                        sessionView()
                    }
                    Divider()
                    tagsView()
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(person.name), displayMode: .inline)
    }
    
    // MARK: - Body Builders
    func profileView() -> some View {
        return ZStack {
            Rectangle()
                .fill(Color(.secondarySystemBackground))
                .frame(height: 200)
            VStack {
                Image(person.name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .mask(Circle())
                Text(person.name)
                    .font(.headline)
                Text(person.organization)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .bold()
            }
        }
    }
    
    func sessionView() -> AnyView? {
        guard let sessions = (person as? ProtoSpeaker)?.sessions else {
            return nil
        }
        return AnyView(VStack(alignment: .leading, spacing: 8) {
            Text("Sessions")
                .font(.headline)
            ForEach(sessions, id: \.description) {
                Text($0)
                    .font(.subheadline)
            }
        })
    }
    
    func tagsView() -> some View {
        return VStack(alignment: .leading, spacing: 8) {
            Text("Role")
                .font(.headline)
            HStack {
                ForEach(roles(), id: \.description) {
                    Text($0)
                        .font(.subheadline)
                        .padding(6)
                        .colorInvert()
                        .background(Color(.secondaryLabel))
                        .cornerRadius(9)
                }
            }
        }
    }
    
    //MARK: - Helper
    func roles() -> [String] {
        guard person.name != "김정" else { // TODO: ProtoData 형식을 role별로 별개로 만들어서 좀.. 처리가 힘드네요. 아직은 김정님 뿐이라 임시적으로 이렇게 둘게요. 데이터 형식 수정과 함께 변경하겠습니당!!
            return ["Organizer", "Speaker", "Staff"]
        }
        switch type {
        case .staffs:
            return ["Staff"]
        case .speakers:
            return ["Speaker"]
        }
    }
    
    func tags(of person: SuperPerson) -> String {
        return person.tags.map {"#" + $0 }.joined(separator: " ")
    }
}

// MARK: - Preview
struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        
        let people = ProtoStaff.makeProtoData()
        return Group {
            NavigationView {
                PersonView(type: .staffs, person: people[0])
            }
            NavigationView {
                PersonView(type: .staffs, person: people[0])
            }
            .environment(\.colorScheme, .dark)
            NavigationView {
                PersonView(type: .staffs, person: people[0])
            }
            .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}


