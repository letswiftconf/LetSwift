//
//  NewEventView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewEventView: View {
    @Binding var presentNew: Bool
    
    var body: some View {
        NavigationView {
            EventDetailView()
                .navigationBarTitle("New Event")
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
struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(presentNew: .constant(true))
    }
}
#endif
