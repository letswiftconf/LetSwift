//
//  SessionListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 2019/08/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SessionListView: View {
    @State private var sessions = [Session]()
    
    @State private var presentNew = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sessions) { item in
                    NavigationLink(destination: SessionDetailView()) {
                        Text("Session")
                    }
                }
            }
            .navigationBarTitle("Sessions")
            .navigationBarItems(trailing:
                Button(action: addNewSession) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $presentNew) {
            NewSessionView(presentNew: self.$presentNew)
        }
    }
    
    // MARK: - Action
    private func addNewSession() {
        presentNew.toggle()
    }
}

#if DEBUG
struct SessionListView_Previews: PreviewProvider {
    static var previews: some View {
        SessionListView()
    }
}
#endif
