//
//  PeopleList.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/24.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PeopleList: View {
    let type: PeopleType
    var people: [SuperPerson]
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Text(type.title)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                NavigationLink(destination: AllPeopleList(type: type, people: people)) {
                    HStack(alignment: .center, spacing: 4) {
                        Text("모두 보기")
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 14, weight: .bold, design: .default))
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 8) {
                    self.cells
                }
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: - Body Builder
    
    var cells: AnyView {
        switch type {
        case .speakers:
            return AnyView(
                ForEach(people.compactMap { $0 as? ProtoSpeaker }, id: \.self) { person in
                    NavigationLink(destination: ProfileDetailView(type: self.type, person: person)) {
                        SpeakerCell(speaker: person)
                            .frame(width: 100)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                }
                .buttonStyle(PlainButtonStyle()))
        case .staffs:
            return AnyView(
                ForEach(people.compactMap { $0 as? ProtoStaff }, id: \.self) { person in
                    NavigationLink(destination: ProfileDetailView(type: self.type, person: person)) {
                        StaffCell(staff: person)
                            .frame(width: 100)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                }
                .buttonStyle(PlainButtonStyle()))
            //        default:
            //            return AnyView(
            //                ForEach(people, id: \.self) { person in
            //                    NavigationLink(destination: PersonView(type: self.type, person: person)) {
            //                        PersonCell(person: person)
            //                            .frame(width: 100)
            //                    }
            //                }
            //                .buttonStyle(PlainButtonStyle()))
        }
    }
}

extension PeopleList {
    enum PeopleType {
        case speakers
        //        case sponsors
        //        case organizers
        case staffs
        
        var title: String {
            switch self {
            case .speakers: return "발표자"
                //            case .sponsors: return "Sponsors"
            //            case .organizers: return "Organizers"
            case .staffs: return "스태프"
            }
        }
    }
}

// MARK: - Preview
struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        let people = ProtoStaff.makeProtoData()
        return Group {
            PeopleList(type: .staffs, people: people)
            PeopleList(type: .staffs, people: people)
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
            PeopleList(type: .staffs, people: people)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .previewLayout(.sizeThatFits)
        .background(Color(.systemBackground))
    }
}
