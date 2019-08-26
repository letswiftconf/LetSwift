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
    
    //    private var isFormValid: Bool {
    //        if service != .unspecified &&
    //            URL(string: urlString) != nil { return true }
    //        else { return false }
    //    }
    
    // MARK: - Button
    private var saveButton: some View {
        Button(action: save) {
            Text("Save")
        }
    }
    
    private  var cancelButton: some View {
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
                                    trailing: saveButton)//.disabled(!isFormValid))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Action
    private func save() {
        account.url = account.url(path: urlPath) ?? SocialAccount.dummy.url
        participant.socialAccounts.append(account)
        dismiss()
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
