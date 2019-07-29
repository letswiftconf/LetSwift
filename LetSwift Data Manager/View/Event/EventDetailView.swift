//
//  EventDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct EventDetailView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Description", text: $description)
            DatePicker(selection: $date, displayedComponents: [.date]) {
                Text("Date")
            }
        }
        .listStyle(GroupedListStyle())
    }
}

#if DEBUG
struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView()
    }
}
#endif
