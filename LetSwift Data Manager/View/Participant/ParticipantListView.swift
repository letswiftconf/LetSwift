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
    
    // MARK: - Body
    private var newButton: some View {
        Button(action: presentNewParticipant) {
            Image(systemName: "plus")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(store.participants) { participant in
                    NavigationLink(destination: ParticipantDetailView(participant: participant)) {
                        ParticipantRow(participant: participant)
                    }
                }
            }
            .navigationBarTitle("Participants")
            .navigationBarItems(trailing: newButton)
        }
        .sheet(isPresented: $presentNew) {
            NewParticipantView()
        }
    }
    
    // MARK: - Action
    private func presentNewParticipant() {
        presentNew.toggle()
    }
}

#if DEBUG
struct ParticipantListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantListView()
            .environmentObject(DataStore.shared)
    }
}
#endif
