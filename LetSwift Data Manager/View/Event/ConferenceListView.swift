//
//  ConferenceListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ConferenceListView: View {
    @State private var presentNew = false
    
    @EnvironmentObject var store: DataStore
    
    private var addButton: some View {
        Button(action: addNewEvent) {
            Image(systemName: "plus")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.conferences) { conference in
                    NavigationLink(destination: ConferenceDetailView().environmentObject(conference)) {
                        ConferenceRow(conference: conference)
                    }
                }
            }
            .navigationBarTitle("Conferences")
            .navigationBarItems(trailing: addButton)
        }
            
        .sheet(isPresented: $presentNew) {
            NewConferenceView()
                .environmentObject(self.store.conferences.last!)
        }
    }
    
    // MARK: - Action
    private func addNewEvent() {
        store.createNewConference()
        presentNew.toggle()
    }
}

#if DEBUG
struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceListView()
    }
}
#endif
