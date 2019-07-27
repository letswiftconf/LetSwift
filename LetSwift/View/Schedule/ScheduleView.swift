//
//  ScheduleView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        NavigationView {
            List {
                Text("List")
            }
            .navigationBarTitle("Schedule")
        }
    }
}

#if DEBUG
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
#endif
