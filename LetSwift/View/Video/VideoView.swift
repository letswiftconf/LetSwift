//
//  VideoView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct VideoView: View {
    var body: some View {
        NavigationView {
            List {
                Text("List")
            }
            .navigationBarTitle("Video")
        }
    }
}

#if DEBUG
struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
#endif
