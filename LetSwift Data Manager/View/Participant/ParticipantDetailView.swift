//
//  ParticipantDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ParticipantDetailView: View {
    @State private var role = ""
    @State private var profile = ""
    
    var body: some View {
        Form {
            Section(header: Text("Role")) {
                Picker("Role", selection: $role) {
                    List {
                        Text("Organizer")
                    }
                }
            }
            Section(header: Text("Profile")) {
                Picker("Role", selection: $profile) {
                    List {
                        Text("User")
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

#if DEBUG
struct ParticipantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantDetailView()
    }
}
#endif
