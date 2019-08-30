//
//  SessionDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 2019/08/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SessionDetailView: View {
    @State private var presentNewVideo = false
    
    @ObservedObject var session: Session
    
    // MARK: - Body
    var body: some View {
        Form {
            Section() {
                TextField("Title", text: $session.title)
                Picker("Speaker", selection: $session.speaker) {
                    List {
                        ForEach(DataStore.shared.speakers) { speaker in
                            Text(speaker.profile.preferredName)
                            .tag(speaker)
                        }
                    }
                }
                Picker("Track", selection: $session.track) {
                    ForEach(Session.Track.allCases) { track in
                        Text(track.localizedName)
                        .tag(track)
                    }
                }
                TextField("Location", text: $session.location)
                DatePicker(selection: $session.timespan.start, displayedComponents: [.hourAndMinute]) {
                    Text("Start Time")
                }
                DatePicker(selection: $session.timespan.end, displayedComponents: [.hourAndMinute]) {
                    Text("End Time")
                }
            }
            Section(header: Text("Description")) {
                TextField("Description", text: $session.description)
            }
            Section(header: Text("Video")) {
                if session.video == nil {
                    Button(action: newVideo) {
                        Text("Add Video...")
                    }
                } else {
                    HStack {
                        Text("URL")
                        Spacer()
                        Text(session.video!.url.absoluteString)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Length")
                        Spacer()
                        Text(session.video!.length.hhmmss.string)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(session.title)
        .sheet(isPresented: $presentNewVideo) {
            NewVideoView(session: self.session)
        }
    }
    
    // MARK: - Action
    private func newVideo() {
        presentNewVideo.toggle()
    }
}

#if DEBUG
struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return SessionDetailView(session: Session.dummy)
    }
}
#endif
