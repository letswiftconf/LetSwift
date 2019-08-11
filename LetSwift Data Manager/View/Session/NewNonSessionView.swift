//
//  NewNonSessionView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 11/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewNonSessionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var nonsession = NonSession.dummy
    
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
            NonSessionDetailView(nonsession: nonsession)
                .navigationBarTitle("New Non-Session")
                .navigationBarItems(leading: cancelButton,
                                    trailing: saveButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Action
    private func save() {
        DataStore.shared.addNew(nonsession: nonsession)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func dismiss() {
        presentationMode.value.dismiss()
    }
}

#if DEBUG
struct NewNonSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewNonSessionView()
    }
}
#endif
