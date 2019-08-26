//
//  SessionListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 2019/08/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SessionListView: View {
    @State private var presentsNew = false
    @State private var selectedIndex = 0
    
    @EnvironmentObject var store: DataStore
    
    // MARK: - Button
    var newButton: some View {
        Button(action: presentNewSession) {
            Image(systemName: "plus")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedIndex) {
                    Text("Session")
                        .tag(0)
                    Text("Non-Session")
                        .tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.leading, .trailing])
                if selectedIndex == 0 {
                    List {
                        ForEach(store.sessions) { session in
                            NavigationLink(destination: SessionDetailView(session: session)) {
                                SessionRow(session: session)
                            }
                        }
                        .onMove(perform: store.moveSessions)
                        .onDelete(perform: store.deleteSessions)
                    }
                } else {
                    List {
                        ForEach(store.nonsessions) { nonsession in
                            NavigationLink(destination: NonSessionDetailView(nonsession: nonsession)) {
                                NonSessionRow(nonsession: nonsession)
                            }
                        }
                        .onMove(perform: store.moveNonsessions)
                        .onDelete(perform: store.deleteNonsessions)
                    }
                }
            }
            .navigationBarTitle("Sessions")
            .navigationBarItems(leading: EditButton(),
                                trailing: newButton)
        }
        .sheet(isPresented: $presentsNew) {
            if self.selectedIndex == 0 {
                NewSessionView()
            } else {
                NewNonSessionView()
            }
        }
    }
    
    // MARK: - Action
    private func presentNewSession() {
        presentsNew.toggle()
    }
}

#if DEBUG
struct SessionListView_Previews: PreviewProvider {
    static var previews: some View {
        SessionListView()
            .environmentObject(DataStore.shared)
    }
}
#endif
