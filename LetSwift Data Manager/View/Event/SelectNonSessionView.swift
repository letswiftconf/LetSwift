//
//  SelectNonSessionView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 12/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SelectNonSessionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var conference: Conference
    @State private var selection = Set<UUID>()
    
    // MARK: - Button
    private var doneButton: some View {
        Button(action: done) {
            Text("Done")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                List(selection: $selection) {
                    ForEach(DataStore.shared.nonsessions, id: \.id) { session in
                        Text("\(session.title)")
                    }
                }
                .environment(\.editMode, .constant(EditMode.active))
            }
            .navigationBarTitle("Select Non-Sessions", displayMode: .inline)
            .navigationBarItems(trailing: doneButton)
        }
    }
    
    // MARK: - Action
    private func done() {
        conference.schedule.nonsessions = DataStore.shared.nonsessions.filter { selection.contains($0.id) }
        dismiss()
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

#if DEBUG
struct SelectNonSessionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectNonSessionView(conference: Conference.dummy)
    }
}
#endif
