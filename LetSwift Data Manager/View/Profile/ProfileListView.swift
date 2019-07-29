//
//  ProfileListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ProfileListView: View {
    @State private var profiles = [Profile]()
    
    @State private var presentNew = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(profiles) { item in
                    NavigationLink(destination: ProfileDetailView()) {
                        Text("Profile")
                    }
                }
            }
            .navigationBarTitle("Profiles")
            .navigationBarItems(trailing:
                Button(action: addNewProfile) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $presentNew) {
            NewProfileView(presentNew: self.$presentNew)
        }
    }
    
    // MARK: - Action
    private func addNewProfile() {
        presentNew.toggle()
    }
}

#if DEBUG
struct ProfileListView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListView()
    }
}
#endif
