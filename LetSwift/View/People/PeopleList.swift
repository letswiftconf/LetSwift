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
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text(type.title)
                    .font(.headline)
                Spacer()
                NavigationLink(destination: AllPeopleList(type: type, people: people)) {
                    Group {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .font(.subheadline)
                }
            }
            .padding(.horizontal)
            .navigationBarTitle(type.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
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
                    NavigationLink(destination: PersonView(type: self.type, person: person)) {
                        SpeakerCell(speaker: person)
                            .frame(width: 100)
                    }
                }
                .buttonStyle(PlainButtonStyle()))
        case .staffs:
            return AnyView(
                ForEach(people.compactMap { $0 as? ProtoStaff }, id: \.self) { person in
                    NavigationLink(destination: PersonView(type: self.type, person: person)) {
                        StaffCell(staff: person)
                            .frame(width: 100)
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
            case .speakers: return "Speakers"
                //            case .sponsors: return "Sponsors"
            //            case .organizers: return "Organizers"
            case .staffs: return "Staffs"
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
            PeopleList(type: .staffs, people: people)
                .previewLayout(layout)
            PeopleList(type: .staffs, people: people)
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            PeopleList(type: .staffs, people: people)
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
