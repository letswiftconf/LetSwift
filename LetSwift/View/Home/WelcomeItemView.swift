//
//  WelcomeItemView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct WelcomeItemView<Content>: View where Content: View {
    let imageName: String
    let content: () -> Content
    
    // MARK: - Initialization
    init(_ imageName: String, @ViewBuilder content: @escaping () -> Content) {
        self.imageName = imageName
        self.content = content
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(self.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                .modifier(RoundedMask())
            VStack(alignment: .leading) {
                content()
            }
            .padding()
        }
    }
}

// MARK: - Preview
struct WelcomeItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeItemView("Sample") {
                Text("Title")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            WelcomeItemView("Sample") {
                Text("Title")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Description")
            }
            .environment(\.colorScheme, .dark)
        }
        .background(Color(.systemBackground))
        .previewLayout(.sizeThatFits)
    }
}
