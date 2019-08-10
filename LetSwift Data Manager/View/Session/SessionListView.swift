//
//  SessionListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 2019/08/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SessionListView: View {
    @State private var presentNew = false
    
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
            List {
                ForEach(store.sessions) { session in
                    NavigationLink(destination: SessionDetailView(session: session)) {
                        SessionRow(session: session)
                    }
                }
            }
            .navigationBarTitle("Sessions")
            .navigationBarItems(trailing: newButton)
        }
        .sheet(isPresented: $presentNew) {
            NewSessionView()
        }
    }
    
    // MARK: - Action
    private func presentNewSession() {
        presentNew.toggle()
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
