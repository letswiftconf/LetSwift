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
                    Image("People")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
//                        .frame(width: .infinity, height: 300)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 240, maxHeight: 240, alignment: .center)
                        .modifier(RoundedMask())
                        .padding(.horizontal)
                    Spacer(minLength: 24)
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
            .navigationBarTitle("사람들")
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
