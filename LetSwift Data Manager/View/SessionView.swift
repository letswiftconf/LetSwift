//
//  SessionView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SessionView: View {
    @State private var items = [1, 2, 3]
    
    var body: some View {
        NavigationView {
            List(items) { item in
                Text("\(item)")
            }
            .navigationBarTitle("Sessions")
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

#if DEBUG
struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
#endif
