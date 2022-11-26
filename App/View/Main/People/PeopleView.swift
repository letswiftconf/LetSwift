//
//  PeopleView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct PeopleView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
//                Image("Placeholder")
//                    .resizable()
//                    .aspectRatio(4 / 3, contentMode: .fill)
//                    .frame(maxWidth: .infinity)
//                    .modifier(RoundedMask())
//                    .modifier(Shadow())
                PeopleGroupedByRoleView()
                    .environmentObject(People(type: .organizer))
//                PeopleGroupedByRoleView()
//                    .environmentObject(People(type: .panels))
                PeopleGroupedByRoleView()
                    .environmentObject(People(type: .staff))
            }
            .padding()
        }
        .navigationTitle("사람들")
    }
}

// MARK: - Preview
struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
//            PeopleView()
//        }
        PeopleView()
            .previewLayout(.sizeThatFits)
//        .previewAsComponent()
    }
}
