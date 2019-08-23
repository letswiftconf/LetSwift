//
//  ProfileListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ProfileListView: View {
    @State private var presentsNew = false
    
    @EnvironmentObject var store: DataStore
    
    // MARK: - Button
    private var newButton: some View {
        Button(action: presentNewProfile) {
            Image(systemName: "plus")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(store.profiles) { profile in
                    NavigationLink(destination: ProfileDetailView(profile: profile)) {
                        ProfileRow(profile: profile)
                    }
                }
                .onMove(perform: store.moveProfiles)
                .onDelete(perform: store.deleteProfiles)
            }
            .navigationBarTitle("Profiles")
            .navigationBarItems(leading: EditButton(),
                                trailing: newButton)

        }
        .sheet(isPresented: $presentsNew) {
            NewProfileView()
        }
    }
    
    // MARK: - Action
    private func presentNewProfile() {
        presentsNew.toggle()
    }
}

#if DEBUG
struct ProfileListView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListView()
            .environmentObject(DataStore.shared)
    }
}
#endif
