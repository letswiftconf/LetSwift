//
//  ProfileDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ProfileDetailView: View {
    @ObservedObject var profile: Profile
    
    // MARK: - Body
    var body: some View {
        Form {
            Section() {
                TextField("Family Name", text: $profile.familyName)
                TextField("Given Name", text: $profile.givenName)
                TextField("Nickname", text: $profile.nickname)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(profile.preferredName)
    }
}

#if DEBUG
struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(profile: Profile.dummy)
    }
}
#endif
