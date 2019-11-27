//
//  ProfileDetailView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/24.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ProfileDetailView: View {
    let type: PeopleList.PeopleType
    var person: SuperPerson
    
    // MARK: - Body
    var body: some View {
        Group {
            if type == .speakers {
                ScrollView {
                    VStack(alignment: .leading) {
                        profileView
                        VStack(alignment: .leading, spacing: 24) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(person.description)
                                    .font(.body)
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
                        }
                        .padding()
                    }
                    .navigationBarTitle(Text(person.name))
                }
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("Logo_Background"))
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .blur(radius: 13, opaque: false)
                    Rectangle()
                        .foregroundColor(Color(.tertiarySystemFill))
                    VStack(alignment: .center, spacing: 12) {
                        ProfileImageView(imageName: person.name)
                            .frame(width: 160, height: 160)
                        VStack(spacing: 4) {
                            Text(person.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Text(person.organization)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                        }
                        .shadow(color: .white, radius: 33, x: 0, y: 0)
                        Text(person.description)
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(width: 320)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .shadow(color: .white, radius: 33, x: 0, y: 0)
                        if !person.tags.isEmpty {
                            HStack {
                                Text(person.tags.map {"#" + $0 }.joined(separator: " "))
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(.tertiaryLabel))
                                    .shadow(color: .white, radius: 33, x: 0, y: 0)
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    // MARK: - View components
    private var profileView: some View {
        return ZStack {
            HomeHeroView()
                .blur(radius: 13, opaque: true)
            VStack(spacing: 12) {
                ProfileImageView(imageName: person.name)
                    .frame(width: 120, height: 120)
                VStack(spacing: 4) {
                    Text(person.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(person.organization)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private func sessionView() -> AnyView? {
        guard let sessions = (person as? ProtoSpeaker)?.sessions else {
            return nil
        }
        return AnyView(VStack(alignment: .leading, spacing: 8) {
            Text("Sessions")
                .font(.headline)
            ForEach(sessions, id: \.description) {
                Text($0)
                    .font(.footnote)
            }
        })
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
                ProfileDetailView(type: .speakers, person: ProtoSpeaker.speakers[4])
            }
            NavigationView {
                ProfileDetailView(type: .staffs, person: people[3])
            }
            .environment(\.colorScheme, .dark)
            NavigationView {
                ProfileDetailView(type: .staffs, person: people[3])
            }
            .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}


