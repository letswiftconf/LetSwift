//
//  SocialAccountDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 11/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SocialAccountDetailView: View {
    @ObservedObject var account: SocialAccount
    
    // MARK: - Body
    var body: some View {
        Form {
            Picker("Service", selection: $account.category) {
                List {
                    ForEach(SocialAccount.Service.allCases) { service in
                        Text(service.localizedName)
                            .tag(service)
                    }
                }
            }
//            TextField("URL", text: $account.url.absoluteString)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(account.category.localizedName)
    }
}

#if DEBUG
struct SocialAccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SocialAccountDetailView(account: SocialAccount.dummy)
    }
}
#endif
