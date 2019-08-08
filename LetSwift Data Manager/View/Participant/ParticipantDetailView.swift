//
//  ParticipantDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ParticipantDetailView: View {
    @State private var presentNew = false
    
    @EnvironmentObject var participant: Participant
    
    @State private var role = ""
    @State private var profile = ""
    @State private var description = ""
    @State private var imageUrl = ""
    
    private var newSocialAccountButton: some View {
        Button(action: newSocialAccount) {
            Text("New Social Account...")
        }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Profile", selection: $profile) {
                    List {
                        Text("User")
                    }
                }
                Picker("Role", selection: $role) {
                    List {
                        ForEach(Participant.Role.allCases) { role in
                            Text(role.localizedName)
                        }
                    }
                }
                TextField("Description", text: $participant.description)
            }
            Section(header: Text("Image")) {
                TextField("Image URL", text: $imageUrl)
            }
            Section(header: Text("Social Account")) {
                newSocialAccountButton
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(participant.profile.preferredName)
        .sheet(isPresented: $presentNew) {
            NewSocialAccountView()
        }
    }
    
    // MARK: - Action
    private func newSocialAccount() {
        presentNew.toggle()
    }
}

#if DEBUG
struct ParticipantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantDetailView()
    }
}
#endif
