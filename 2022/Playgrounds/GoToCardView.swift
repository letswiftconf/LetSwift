//
//  CardItem.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct GoToCardView: View {
    
    @State private var isShowModal = false
    @State var state: String = ""
    @State var title: String = ""
    
    var body: some View {
        Button {
            self.isShowModal = true
        } label: {
            boxText(state: state, title: title)
        }
        .fullScreenCover(isPresented: $isShowModal) {
            if let user = SharedPreference.shared.cheeringCard {
                if user.name.isEmpty {
                    NicknameView(isShowModal: $isShowModal)
                } else {
                    CardView(showModal: $isShowModal)
                        .onDisappear(){
                            setTitle()
                        }
                }
            } else {
                NicknameView(isShowModal: $isShowModal)
                    .onDisappear(){
                        setTitle()
                    }
            }
        }
        .onAppear(){
            setTitle()
        }
    }
}

extension GoToCardView {
    private func setTitle() {
        if let user = SharedPreference.shared.cheeringCard {
            if user.name.isEmpty {
                state = "?"
                title = "나의 playground card\n뽑으러 가기"
            } else {
                state = "♥️"
                title = "\(user.category) \(user.name)님,\n전체 결과를 확인해보세요!"
            }
        } else {
            state = "?"
            title = "나의 playground card\n뽑으러 가기"
        }
    }
    
    @ViewBuilder func gradationBox() -> some View {
        Rectangle()
            .fill(LinearGradient.gradientOrange.opacity(0.45))
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
    }
    
    @ViewBuilder func boxText(state: String, title: String) -> some View {
        HStack(alignment: .center) {
            Text(state)
                .font(.bodyRegular)
                .frame(width: 40, height: 55)
                .background(state == "?" ? Color.white : Color.backgroundBlack)
                .cornerRadius(3)
                .foregroundColor(.black)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
            Text(title)
                .padding(.leading, 20)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .font(.bodyBold)
            Spacer()
            Image("chevron")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .frame(height: 90)
        .background(gradationBox())
    }
}

//struct CardItem_Previews: PreviewProvider {
//    static var previews: some View {
//        GoToCardView()
//    }
//}
