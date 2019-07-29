//
//  ParticipantListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ParticipantListView: View {
    @State private var participants = [Profile]()
    
    @State private var presentNew = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(participants) { item in
                    NavigationLink(destination: ParticipantDetailView()) {
                        Text("Participant")
                    }
                }
            }
            .navigationBarTitle("Participants")
            .navigationBarItems(trailing:
                Button(action: addNewParticipants) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $presentNew) {
            NewParticipantView(presentNew: self.$presentNew)
        }
    }
    
    // MARK: - Action
    private func addNewParticipants() {
        presentNew.toggle()
    }
}

#if DEBUG
struct ParticipantListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantListView()
    }
}
#endif
