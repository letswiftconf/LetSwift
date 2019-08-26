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
    @Binding var urlPath: String
    
    // MARK: - Body
    var body: some View {
        Form {
            Picker("Service", selection: $account.category) {
                ForEach(SocialAccount.Service.allCases) { service in
                    Text(service.localizedName)
                        .tag(service)
                }
            }
            NavigationLink(
                destination: NewSocialAccountURLView(urlPath: $urlPath, service: account.category)
            ) {
                Text("URL")
                Spacer()
                Text("\(account.urlString(path: urlPath))")
                    .foregroundColor(.secondary)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(account.category.localizedName)
    }
}

// MARK: - NewSocialAccountURLView
private struct NewSocialAccountURLView: View {
    
    @Binding var urlPath: String
    let service: SocialAccount.Service
    
    // MARK: - Body
    var body: some View {
        Form {
            Section(header: Text("Social Account URL")) {
                textField
            }
        }
    }
    
    // MARK: - Computed Variables
    var textField: AnyView {
        switch service {
        case .unspecified:
            return AnyView(TextField("", text: $urlPath))
        case .email:
            return AnyView(TextField("example@example.com", text: $urlPath))
        case .website:
            return AnyView(TextField("www.example.com", text: $urlPath))
        default:
            return AnyView(HStack(alignment: .bottom, spacing: 1) {
                Text(service.domain + "/")
                TextField("id", text: $urlPath)
            })
        }
    }
}


#if DEBUG
struct SocialAccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SocialAccountDetailView(account: SocialAccount.dummy, urlPath: .constant(""))
    }
}
#endif
