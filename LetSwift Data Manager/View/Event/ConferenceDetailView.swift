//
//  ConferenceDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ConferenceDetailView: View {
    @ObservedObject var conference: Conference
    
    // MARK: - Body
    var body: some View {
        Form {
            TextField("Title", text: $conference.title)
            TextField("Description", text: $conference.description)
            DatePicker(selection: $conference.date, displayedComponents: [.date]) {
                Text("Date")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(conference.title)
    }
}

#if DEBUG
struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceDetailView(conference: Conference.dummy)
    }
}
#endif
