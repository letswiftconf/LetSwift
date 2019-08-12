//
//  ConferenceListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ConferenceListView: View {
    @State private var presentsNew = false
    
    @EnvironmentObject var store: DataStore
    
    // MARK: - Button
    private var newButton: some View {
        Button(action: presentNewConference) {
            Image(systemName: "plus")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(store.conferences) { conference in
                    NavigationLink(destination: ConferenceDetailView(conference: conference)) {
                        ConferenceRow(conference: conference)
                    }
                }
            }
            .navigationBarTitle("Conferences")
            .navigationBarItems(trailing: newButton)
        }
        .sheet(isPresented: $presentsNew) {
            NewConferenceView()
        }
    }
    
    // MARK: - Action
    private func presentNewConference() {
        presentsNew.toggle()
    }
}

#if DEBUG
struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceListView()
            .environmentObject(DataStore.shared)
    }
}
#endif
