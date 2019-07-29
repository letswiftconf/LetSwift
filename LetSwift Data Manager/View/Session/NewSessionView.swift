//
//  NewSessionView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 2019/08/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewSessionView: View {
    @Binding var presentNew: Bool
    
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
        presentNew.toggle()
    }
    
    private func cancel() {
        presentNew.toggle()
    }
}

#if DEBUG
struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView(presentNew: .constant(true))
    }
}
#endif
