//
//  NewParticipantView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewParticipantView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var participant = Participant.dummy
    
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
            ParticipantDetailView(participant: participant)
                .navigationBarTitle("New Participant")
                .navigationBarItems(leading: cancelButton,
                trailing: saveButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Action
    private func save() {
        DataStore.shared.addNew(participant: participant)
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
struct NewParticipantView_Previews: PreviewProvider {
    static var previews: some View {
        NewParticipantView()
    }
}
#endif
