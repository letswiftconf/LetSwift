//
//  NewParticipantView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewParticipantView: View {
    @Binding var presentNew: Bool
    
    var body: some View {
        NavigationView {
            ParticipantDetailView()
                .navigationBarTitle("New Participant")
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
    private func save() {
        presentNew.toggle()
    }
    
    private func cancel() {
        presentNew.toggle()
    }
}

#if DEBUG
struct NewParticipantView_Previews: PreviewProvider {
    static var previews: some View {
        NewParticipantView(presentNew: .constant(true))
    }
}
#endif
