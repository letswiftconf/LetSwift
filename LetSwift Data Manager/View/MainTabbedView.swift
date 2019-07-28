//
//  MainTabbedView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct MainTabbedView: View {
    var body: some View {
        TabbedView {
            SessionView()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Sessions")
                    }
            }
            .tag(0)
            PeopleView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("People")
                    }
            }
            .tag(1)
        }
    }
}

#if DEBUG
struct MainTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbedView()
    }
}
#endif
