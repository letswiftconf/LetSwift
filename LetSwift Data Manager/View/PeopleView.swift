//
//  PeopleView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PeopleView: View {
    @State private var items = [1, 2, 3]
    
    var body: some View {
        NavigationView {
            List(items) { item in
                NavigationLink(destination: PersonView()) {
                    Text("\(item)")
                }
            }
            .navigationBarTitle("People")
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Text("Edit")
                        })
                            .padding(.trailing, 8)
                        Button(action: {
                            self.items.append(5)
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
            )
        }
    }
}

struct PersonView: View {
    @State private var name: String = ""
    
    var body: some View {
        List {
            HStack {
                Text("Name")
                TextField("Name", text: $name)
            }
            HStack {
                Text("Nickname")
            }
            HStack {
                Text("description")
            }
            HStack {
                Text("Image")
            }
        }
        .listStyle(.grouped)
            .navigationBarTitle("Person")
    }
}

#if DEBUG
struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
#endif
