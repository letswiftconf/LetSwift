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
            VStack {
                Text("Organizer")
                Text("Sponsor")
                Text("Staff")
            }
        }
        .navigationTitle("People")
    }
}

// MARK: - Preview
struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PeopleView()
        }
        .previewAsScreen()
    }
}
