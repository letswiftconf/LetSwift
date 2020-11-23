//
//  WebSourceCodeItemView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/24.
//

import SwiftUI

struct WebSourceCodeItemView: View {
    let width: CGFloat
    let height: CGFloat
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
            Text("웹 소스코드")
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
    }
}

// MARK: - Preview
struct WebSourceCodeItemView_Previews: PreviewProvider {
    static var previews: some View {
        WebSourceCodeItemView(width: .homeItemHeight, height: .homeItemHeight)
            .previewAsComponent()
    }
}
