//
//  AskQuestionItemView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/24.
//

import SwiftUI

struct AskQuestionItemView: View {
    let width: CGFloat
    let height: CGFloat
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
            Text("사전 질문 남기기")
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
    }
}

// MARK: - Preview
struct AskQuestionItemView_Previews: PreviewProvider {
    static var previews: some View {
        AskQuestionItemView(width: .homeItemHeight, height: .homeItemHeight)
            .previewAsComponent()
    }
}

