//
//  NewSocialAccountView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewSocialAccountView: View {
    @State private var selection = ""
    @State private var url = ""
    
    @Binding var presentNew: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Service", selection: $selection) {
                    List {
                        Text("Email")
                    }
                }
                TextField("URL", text: $url)
            }
            .navigationBarTitle("New Social Account")
            .navigationBarItems(leading:
                Button(action: save, label: {
                    Text("Cancel")
                })
                , trailing:
                Button(action: cancel, label: {
                    Text("Save")
                })
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Action
    private func newSocialAccount() {
        
    }
    
    private func save() {
        presentNew.toggle()
    }
    
    private func cancel() {
        presentNew.toggle()
    }
}

#if DEBUG
struct NewSocialAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewSocialAccountView(presentNew: .constant(true))
    }
}
#endif
