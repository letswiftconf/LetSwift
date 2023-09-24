//
//  SelfieCardView.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/24.
//

import SwiftUI

// TODO: 카드 디자인에 맞춰서 컴포넌트 제작 필요.
struct SelfieCardView: View {
    
    @State var isModal: Bool = false
    
    var body: some View {
        Button {
            self.isModal = true
        } label: {
            Text("인증샷 찍으러 가기")
                .foregroundColor(.white)
                .font(.bodyBold)
        }
        .frame(height: 90)
        .frame(maxWidth: .infinity)
        .cornerRadius(5)
        .background(design())
        .fullScreenCover(isPresented: $isModal) {
            SelfieFrameView()
        }
    }
    
    private func design() -> some View {
        // 공통으로 사용하고 있는게 있는지 확인 필요.
        
        return Rectangle()
            .fill(Color.primary_2023)
            .shadow(color: Color.primary_2023.opacity(0.5), radius: 4, x: 4, y: 4)
    }
}

struct SelfieCardView_Previews: PreviewProvider {
    static var previews: some View {
        SelfieCardView()
    }
}
