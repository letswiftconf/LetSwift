//
//  VenueView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct VenueView: View {
    var body: some View {
        NavigationView {
            List {
                Text("List")
            }
            .navigationBarTitle("Venue")
        }
    }
}

#if DEBUG
struct VenueView_Previews: PreviewProvider {
    static var previews: some View {
        VenueView()
    }
}
#endif
