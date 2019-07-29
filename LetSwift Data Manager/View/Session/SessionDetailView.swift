//
//  SessionDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 2019/08/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SessionDetailView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var speakerReference = ""
    @State private var location = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var trackSelection = ""
    @State private var videoReference = ""
    
    @State private var presentNewVideo = false
    
    var body: some View {
        Form {
            Section(header: Text("Information")) {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                Picker("Speaker", selection: $speakerReference) {
                    List {
                        Text("Speaker")
                    }
                }
                TextField("Location", text: $location)
                DatePicker(selection: $startTime, displayedComponents: [.hourAndMinute]) {
                    Text("Start Time")
                }
                DatePicker(selection: $endTime, displayedComponents: [.hourAndMinute]) {
                    Text("End Time")
                }
                Picker("Track", selection: $trackSelection) {
                    List {
                        Text("Session")
                        Text("Workshop")
                    }
                }
            }
            Section(header: Text("Video")) {
                Picker("Video", selection: $trackSelection) {
                    List {
                        Text("Video")
                    }
                }
                Button(action: newVideo) {
                    Text("New Video...")
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
    
    private func newVideo() {
        presentNewVideo.toggle()
    }
}

#if DEBUG
struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView()
    }
}
#endif
