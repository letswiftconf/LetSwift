//
//  ParticipantListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ParticipantListView: View {
    @State private var presentNew = false
    
    @EnvironmentObject var store: DataStore
    
    private var addButton: some View {
        Button(action: addNewParticipants) {
            Image(systemName: "plus")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.participants) { participant in
                    NavigationLink(destination: ParticipantDetailView().environmentObject(participant)) {
                        ParticipantRow(participant: participant)
                    }
                }
            }
            .navigationBarTitle("Participants")
            .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: $presentNew) {
            NewParticipantView()
                .environmentObject(self.store)
                .environmentObject(self.store.participants.last!)
        }
    }
    
    // MARK: - Action
    private func addNewParticipants() {
        store.createNewParticipant()
//        presentNew.toggle()
    }
}

#if DEBUG
struct ParticipantListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantListView()
    }
}
#endif
