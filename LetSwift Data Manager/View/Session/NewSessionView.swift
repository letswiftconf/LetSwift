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
    
    var body: some View {
        NavigationView {
            SessionDetailView()
                .navigationBarTitle("New Session")
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
        presentationMode.value.dismiss()
    }
    
    private func cancel() {
        presentationMode.value.dismiss()
    }
}

#if DEBUG
struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView()
    }
}
#endif
