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
                SpeakerDetailView(person: person)
            } else {
                StaffDetailView(person: person)
            }
        }
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


