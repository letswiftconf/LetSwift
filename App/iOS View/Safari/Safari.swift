//
//  Safari.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/08.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct Safari: View {
    let url: URL
    var entersReaderIfAvailable = false
    
    // MARK: - Body
    var body: some View {
        SafariView(url: url, entersReaderIfAvailable: false)
            .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Preview
struct Safari_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "http://letswift.kr/")!
        return Safari(url: url, entersReaderIfAvailable: false)
            .previewAsScreen()
    }
}
