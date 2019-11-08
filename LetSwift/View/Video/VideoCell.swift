//
//  VideoCell.swift
//  LetSwift
//
//  Created by HyungJung Kim on 01/11/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI


struct VideoCell: View {
    
    // MARK: - body
    
    var body: some View {
        NavigationLink(
            destination: Safari(url: (self.session.video?.url)!, entersReaderIfAvailable: false)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.top)
        ) {
            VStack(alignment: .leading) {
                Text(self.session.title)
                    .lineLimit(1)
                Text(self.session.speaker.profile.preferredName)
                    .font(.caption)
                    .foregroundColor(Color(.secondaryLabel))
            }
        }
    }
    
    // MARK: - internal
    
    @ObservedObject var session: Session
    
}
