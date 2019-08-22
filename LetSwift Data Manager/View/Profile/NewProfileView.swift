//
//  NewProfileView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var profile = Profile.dummy
    
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
            ProfileDetailView(profile: profile)
                .navigationBarTitle("New Profile")
                .navigationBarItems(leading: cancelButton,
                                    trailing: saveButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Action
    private func save() {
        DataStore.shared.addNew(profile: profile)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

#if DEBUG
struct NewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NewProfileView()
    }
}
#endif
