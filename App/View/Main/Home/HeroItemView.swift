//
//  HeroItemView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/24.
//

import SwiftUI

struct HeroItemView: View {
    let height: CGFloat
    
    @State private var presentAR = false
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: height)
            VStack(alignment: .leading, spacing: 4) {
                Text("집에서 함께해요")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("안전하게 집에서 스위프트하는 방법")
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("레츠스위프트 2020 테크토크와 함께하세요. 매일 저녁 여러 가지 기술 주제에 대해 토론할 수 있습니다.")
                    .font(.footnote)
            }
            .padding()
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
        .fullScreenCover(isPresented: $presentAR) {
            ARView(assetName: "let")
                .ignoresSafeArea(.all, edges: .all)
        }
        .onTapGesture {
            presentAR.toggle()
        }
    }
}

// MARK: - Preview
struct HeroItemView_Previews: PreviewProvider {
    static var previews: some View {
        HeroItemView(height: .homeItemHeight)
            .previewAsComponent()
    }
}
