//
//  VideoView.swift
//  LetSwift
//
//  Created by HyungJung Kim on 31/10/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI


struct VideoView: View {
    
    // MARK: - body
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("2018")) {
                    ForEach(Session.sessionsFrom2018) { session in
                        VideoCell(session: session)
                    }
                }
                
                Section(header: Text("2017")) {
                    ForEach(Session.sessionsFrom2017) { session in
                        VideoCell(session: session)
                    }
                }
                
                Section(header: Text("2016")) {
                    ForEach(Session.sessionsFrom2016) { session in
                        VideoCell(session: session)
                    }
                }
            }
            .navigationBarTitle("Video")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}


#if DEBUG
struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
#endif
