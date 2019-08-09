//
//  NewSocialAccountView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewSocialAccountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var participant: Participant
    @State private var service = SocialAccount.Service.unspecified
    @State private var urlString = ""
    
    private var isFormValid: Bool {
        if service != .unspecified &&
            URL(string: urlString) != nil { return true }
        else { return false }
    }
    
    // MARK: - Button
    private var saveButton: some View {
        Button(action: save, label: {
            Text("Done")
        })
    }
    
    private var cancelButton: some View {
        Button(action: cancel, label: {
            Text("Cancel")
        })
    }
    
    // MARK: - Body
    var body: some View {
        Form {
            Picker("Service", selection: $service) {
                List {
                    ForEach(SocialAccount.Service.allCases) { service in
                        Text(service.localizedName)
                            .tag(service)
                    }
                }
            }
            TextField("URL", text: $urlString)
        }
        .navigationBarTitle("New Social Account")
        .navigationBarItems(leading: cancelButton,
                            trailing: saveButton.disabled(!isFormValid))
    }
    
    // MARK: - Action
    private func save() {
        guard let url = URL(string: urlString) else {
            return
        }
        let account = SocialAccount(category: service,
                                    url: url)
        participant.socialAccounts.append(account)
        presentationMode.value.dismiss()
    }
    
    private func cancel() {
        presentationMode.value.dismiss()
    }
}

#if DEBUG
struct NewSocialAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewSocialAccountView()
    }
}
#endif
