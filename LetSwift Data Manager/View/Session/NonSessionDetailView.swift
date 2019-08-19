//
//  NonSessionDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 11/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NonSessionDetailView: View {
    @State private var presentNewVideo = false
    
    @ObservedObject var nonsession: NonSession
    
    // MARK: - Body
    var body: some View {
        Form {
            Section() {
                TextField("Title", text: $nonsession.title)
                TextField("Location", text: $nonsession.location)
                DatePicker(selection: $nonsession.timespan.start, displayedComponents: [.hourAndMinute]) {
                    Text("Start Time")
                }
                DatePicker(selection: $nonsession.timespan.end, displayedComponents: [.hourAndMinute]) {
                    Text("End Time")
                }
                TextField("Description", text: $nonsession.description)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(nonsession.title)
    }
    
    // MARK: - Action
    private func newVideo() {
        presentNewVideo.toggle()
    }
}

#if DEBUG
struct NonSessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NonSessionDetailView(nonsession: NonSession.dummy)
    }
}
#endif
