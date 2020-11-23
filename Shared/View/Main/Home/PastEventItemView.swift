//
//  PastEventItemView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/24.
//

import SwiftUI

struct PastEventItemView: View {
    let height: CGFloat
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: height)
            Text("이전 행사들")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
    }
}

// MARK: - Preview
struct PastEventItemView_Previews: PreviewProvider {
    static var previews: some View {
        PastEventItemView(height: .homeItemHeight)
            .previewAsComponent()
    }
}
