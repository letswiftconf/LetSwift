//
//  ConferenceDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ConferenceDetailView: View {
    @State private var presentSelect = false
    @State private var isSession = true
    
    @ObservedObject var conference: Conference
    
    // MARK: - Body
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $conference.title)
                TextField("Description", text: $conference.description)
                DatePicker(selection: $conference.date, displayedComponents: [.date]) {
                    Text("Date")
                }
            }
            Section(header: Text("Sessions")) {
                ForEach(conference.schedule.sessions) { session in
                    Text(session.title)
                }
                Button(action: selectSession) {
                    Text("Add a New Session...")
                }
            }
            Section(header: Text("Non-Sessions")) {
                ForEach(conference.schedule.nonsessions) { nonsession in
                    Text(nonsession.title)
                }
                Button(action: selectNonSession) {
                    Text("Add a New Non-Session...")
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(conference.title)
        .sheet(isPresented: $presentSelect) {
            if self.isSession == true {
                SelectSessionView(conference: self.conference)
            } else {
                SelectNonSessionView(conference: self.conference)
            }
        }
    }
    
    // MARK: - Action
    private func selectSession() {
        isSession = true
        presentSelect.toggle()
    }
    
    private func selectNonSession() {
        isSession = false
        presentSelect.toggle()
    }
}

#if DEBUG
struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceDetailView(conference: Conference.dummy)
    }
}
#endif
