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
    
    @ObservedObject var participant: Participant
    @ObservedObject private var account = SocialAccount.dummy
    @State private var urlPath: String = ""
    
    private var isFormValid: Bool {
        return self.account.urlString(path: self.urlPath).isValidURL
    }
    
    // MARK: - Button
    private var saveButton: some View {
        Button(action: save) {
            Text("Save")
        }
        .disabled(!isFormValid)
    }
    
    private var cancelButton: some View {
        Button(action: cancel) {
            Text("Cancel")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            SocialAccountDetailView(account: account, urlPath: $urlPath)
                .navigationBarTitle("New Social Account")
                .navigationBarItems(leading: cancelButton,
                                    trailing: saveButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Action
    private func save() {
        if let url = URL(string: self.account.urlString(path: self.urlPath)) {
            self.account.url = url
            self.participant.socialAccounts.append(self.account)
            self.dismiss()
        }
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func dismiss() {
        urlPath = ""
        presentationMode.wrappedValue.dismiss()
    }
}

#if DEBUG
struct NewSocialAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewSocialAccountView(participant: Participant.dummy)
    }
}
#endif
