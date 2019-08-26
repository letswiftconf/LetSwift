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
    @State private var presentsExport = false
    
    @EnvironmentObject var store: DataStore
    
    // MARK: - Button
    private var newButton: some View {
        Button(action: presentNewConference) {
            Image(systemName: "plus")
        }
    }
    
    private var saveButton: some View {
        Button(action: save) {
            Text("Save")
        }
    }
    
    private var exportButton: some View {
        Button(action: export) {
            Text("Export")
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
                .onMove(perform: store.moveConference)
                .onDelete(perform: store.deleteConference)
            }
            .navigationBarTitle("Conferences")
                
            .navigationBarItems(leading:
                HStack {
                    EditButton()
                    saveButton
                    exportButton
                },
                                trailing: newButton)
        }
        .sheet(isPresented: $presentsNew) {
            if self.presentsExport {
                ActivityView()
            } else {
                NewConferenceView()
            }
        }
    }
    
    // MARK: - Action
    private func presentNewConference() {
        self.presentsExport = false
        presentsNew.toggle()
    }
    
    private func save() {
        DataStore.shared.save()
    }
    
    private func export() {
        self.presentsExport = true
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
