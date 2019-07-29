//
//  ProfileDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ProfileDetailView: View {
    @State private var familyName = ""
    @State private var givenName = ""
    @State private var nickname = ""
    @State private var description = ""
    @State private var imageUrl = ""
    
    @State private var presentNew = false
    
    var body: some View {
        Form {
            Section(header: Text("Information")) {
                TextField("Family Name", text: $familyName)
                TextField("Given Name", text: $givenName)
                TextField("Nickname", text: $nickname)
                TextField("Description", text: $description)
            }
            Section(header: Text("Image")) {
                TextField("Image URL", text: $imageUrl)
            }
            Section(header: Text("Social Account")) {
                HStack {
                    Text("Facebook")
                        .foregroundColor(.secondary)
                    Text("facebook.com/user")
                }
                Button(action: newSocialAccount) {
                    Text("New Social Account...")
                }
            }
        }
        .listStyle(GroupedListStyle())
        .sheet(isPresented: $presentNew) {
            NewSocialAccountView(presentNew: self.$presentNew)
        }
    }
    
    private func newSocialAccount() {
        presentNew.toggle()
    }
}

#if DEBUG
struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView()
    }
}
#endif
