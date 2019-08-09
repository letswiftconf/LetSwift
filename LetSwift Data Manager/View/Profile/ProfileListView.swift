//
//  ProfileListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ProfileListView: View {
    @State private var presentNew = false
    
    @EnvironmentObject var store: DataStore
    
    private var addButton: some View {
        Button(action: addNewProfile) {
            Image(systemName: "plus")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.profiles) { profile in
                    NavigationLink(destination: ProfileDetailView()
                        .environmentObject(profile)) {
                        ProfileRow(profile: profile)
                    }
                }
            }
            .navigationBarTitle("Profiles")
            .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: $presentNew) {
            NewProfileView()
            .environmentObject(self.store.profiles.last!)
        }
    }
    
    // MARK: - Action
    private func addNewProfile() {
        store.createNewProfile()
//        presentNew.toggle()
    }
}

#if DEBUG
struct ProfileListView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListView()
    }
}
#endif
