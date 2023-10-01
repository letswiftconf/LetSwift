//
//  PlaygroundMainView.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/24.
//

import SwiftUI

struct PlaygroundMainView: View {
    var body: some View {
        ZStack {
            Color.backgroundBlack.ignoresSafeArea(.all)
            VStack(spacing: 16) {
                GoToCardView()
                SelfieCardView()
            }.padding(20)
        }
    }
}

struct PlaygroundMainView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundMainView()
    }
}
