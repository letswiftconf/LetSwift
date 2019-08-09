//
//  SocialAccountRow.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 08/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SocialAccountRow: View {
    @ObservedObject var account: SocialAccount
    
    var body: some View {
        HStack {
            Text(account.category.localizedName)
                .foregroundColor(.secondary)
            Text(account.url.absoluteString)
        }
    }
}

#if DEBUG
struct SocialAccountRow_Previews: PreviewProvider {
    static var previews: some View {
        SocialAccountRow(account: SocialAccount(category: .email,
                                                      url: URL(string: "mailto://ksquareatm@gmail.com")!))
    }
}
#endif
