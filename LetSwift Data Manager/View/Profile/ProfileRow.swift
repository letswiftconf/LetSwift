//
//  ProfileRow.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 08/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ProfileRow: View {
    @ObservedObject var profile: Profile
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(profile.preferredName)
                .font(.headline)
            HStack {
                Text(profile.familyName)
                Text(profile.givenName)
                if !profile.nickname.isEmpty {
                    Text("\"\(profile.nickname)\"")
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
}

#if DEBUG
struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow(profile: Profile.dummy)
    }
}
#endif
