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
    @State private var urlString: String = ""
    @State private var hours: String = ""
    @State private var minutes: String = ""
    @State private var seconds: String = ""
    
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
                    TextField("URL", text: $urlString)
                    HStack {
                        Text("Length")
                        Spacer()
                        HStack() {
                            TextField("HH", text: $hours)
                            Text(":")
                            TextField("mm", text: $minutes)
                            Text(":")
                            TextField("ss", text: $seconds)
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
        session.video = Video(url: URL(string: urlString)!, length: videoLength)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: - Computed Variables
    private var videoLength: TimeInterval {
        let hhmmss = HHMMSS(hours: Double(hours) ?? 0,
                            minutes: Double(minutes) ?? 0,
                            seconds: Double(seconds) ?? 0)
        return hhmmss.timeInterval
    }
}

#if DEBUG
struct NewVideoView_Previews: PreviewProvider {
    static var previews: some View {
        NewVideoView(session: .dummy)
    }
}
#endif
