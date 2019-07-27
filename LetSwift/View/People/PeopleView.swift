//
//  PeopleView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PeopleView: View {
    var body: some View {
        NavigationView {
            List {
                Text("List")
            }
            .navigationBarTitle("People")
        }
    }
}

#if DEBUG
struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
#endif
