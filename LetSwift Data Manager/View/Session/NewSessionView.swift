//
//  NewSessionView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 2019/08/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewSessionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var session = Session.dummy
    
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
            SessionDetailView(session: session)
                .navigationBarTitle("New Session")
                .navigationBarItems(leading: cancelButton,
                                    trailing: saveButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Action
    private func save() {
        DataStore.shared.addNew(session: session)
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
struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView()
    }
}
#endif
