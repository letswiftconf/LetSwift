//
//  SafariNavigationLink.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/07/27.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SafariNavigationLink: View {
    let title: String
    let url: URL?
    
    var body: some View {
        NavigationLink(destination:
            SafariView(url: url!, entersReaderIfAvailable: false)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.top)
        ) {
            Text(self.title)
        }
    }
}
