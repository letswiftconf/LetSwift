//
//  ParticipantDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ParticipantDetailView: View {
    @State private var presentsNew = false
    
    @ObservedObject var participant: Participant
    
    // MARK: - Button
    private var newSocialAccountButton: some View {
        Button(action: newSocialAccount) {
            Text("New Social Account...")
        }
    }
    
    // MARK: - Body
    var body: some View {
        Form {
            Section {
                Picker("Profile", selection: $participant.profile) {
                    List {
                        ForEach(DataStore.shared.profiles) { profile in
                            Text(profile.preferredName)
                                .tag(profile)
                        }
                    }
                }
                Picker("Role", selection: $participant.role) {
                    List {
                        ForEach(Participant.Role.allCases) { role in
                            Text(role.localizedName)
                                .tag(role)
                        }
                    }
                }
                TextField("Description", text: $participant.description)
            }
            Section(header: Text("Image")) {
                TextField("Image URL", text: $participant.imageURLString)
            }
            Section(header: Text("Social Account")) {
                ForEach(participant.socialAccounts) { account in
                    NavigationLink(destination: NewSocialAccountView(participant: self.participant)) {
                        SocialAccountRow(account: account)
                    }
                }
                newSocialAccountButton
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(participant.profile.preferredName)
        .sheet(isPresented: $presentsNew) {
            NewSocialAccountView(participant: self.participant)
        }
    }
    
    // MARK: - Action
    private func newSocialAccount() {
        presentsNew.toggle()
    }
}

#if DEBUG
struct ParticipantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantDetailView(participant: Participant.dummy)
    }
}
#endif
