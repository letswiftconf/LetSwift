//
//  NewVideoView.swift
//  LetSwift Data Manager
//
//  Created by 김나용 on 27/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NewVideoView: View {
    
    // MARK: - Observed
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var session: Session
    
    // MARK: - @State
    @ObservedObject var viewModel: NewVideoViewModel
    
    // MARK: - Initialization
    init(session: Session) {
        self.session = session
        self.viewModel = .init(video: session.video)
    }
    
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
            Form {
                Section() {
                    TextField("URL", text: $viewModel.urlString)
                    HStack {
                        Text("Length")
                        Spacer()
                        HStack() {
                            TextField("HH", text: $viewModel.hours)
                            Text(":")
                            TextField("mm", text: $viewModel.minutes)
                            Text(":")
                            TextField("ss", text: $viewModel.seconds)
                        }
                    }
                }
            }
            .navigationBarTitle("New Video")
            .navigationBarItems(leading: cancelButton,
                                trailing: saveButton)
        }
    }
    
    // MARK: - Action
    private func save() {
        session.video = viewModel.video
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
struct NewVideoView_Previews: PreviewProvider {
    static var previews: some View {
        NewVideoView(session: .dummy)
    }
}
#endif
