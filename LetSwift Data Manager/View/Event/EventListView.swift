//
//  EventListView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct EventListView: View {
    @State private var events = [Event]()
    
    @State private var presentNew = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(events) { item in
                    NavigationLink(destination: EventDetailView()) {
                        Text("Event")
                    }
                }
            }
            .navigationBarTitle("Events")
            .navigationBarItems(trailing:
                Button(action: addNewEvent) {
                    Image(systemName: "plus")
                }
            )
        }
            
        .sheet(isPresented: $presentNew) {
            NewEventView(presentNew: self.$presentNew)
        }
    }
    
    // MARK: - Action
    private func addNewEvent() {
        presentNew.toggle()
    }
}

#if DEBUG
struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}
#endif
