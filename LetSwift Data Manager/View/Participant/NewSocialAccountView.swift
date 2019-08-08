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
    
    @State private var socialAccount = ""
    @State private var url = ""
    
    private var isFormValid: Bool {
        if socialAccount != "" && url != "" { return true }
        else { return false }
    }
    
    private var doneButton: some View {
        Button(action: done, label: {
            Text("Done")
        })
    }
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Service", selection: $socialAccount) {
                    List {
                        ForEach(SocialAccount.Service.allCases) { service in
                            Text(service.localizedName)
                        }
                    }
                }
                TextField("URL", text: $url)
            }
            .navigationBarTitle("New Social Account")
            .navigationBarItems(trailing: doneButton.disabled(!isFormValid))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Action
    private func newSocialAccount() {
        
    }
    
    private func done() {
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
