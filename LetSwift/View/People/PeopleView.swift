//
//  PeopleView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PeopleView: View {
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("Sample")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 240)
                        .modifier(RoundedMask())
                        .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 24) {
                        PeopleList(type: .speakers, people: ProtoSpeaker.speakers)
                        //                        PeopleList(type: .sponsors, people: [])
                        //                        PeopleList(type: .organizers, people: [])
                        PeopleList(type: .staffs, people: ProtoStaff.makeProtoData())
                    }
                    .frame(alignment: .leading)
                }
                Spacer()
            }
            .navigationBarTitle("People")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Preview
struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PeopleView()
            PeopleView()
                .environment(\.colorScheme, .dark)
            PeopleView()
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
