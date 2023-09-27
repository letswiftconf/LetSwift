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
    
    private let cardDescription =
    """
     🙌 💻 🎨 🍎  🙌 💻 🎨 🍎  🙌 💻 🎨 🍎  🙌 💻 🎨 🍎
    관심있는 Session을 선택하고
    나만의 Deep Dive 카드를 만들어봐요.
     🙌 💻 🎨 🍎  🙌 💻 🎨 🍎  🙌 💻 🎨 🍎  🙌 💻 🎨 🍎

    """
    
    private var btnTitle: String {
        SharedPreference.shared.cheeringCard == nil ? "Deep Dive Card 만들기" : "내 Deep Dive Card 보러가기"
    }
    
    var body: some View {
        VStack {
            Text("Deep Dive Card")
                .font(.head1b)
                .foregroundColor(.white)
            
            // 캐로셀.. 어떡하죵,,
            
            
            Text(self.cardDescription)
                .foregroundColor(.subtext)
                
                .font(.body4m)
                .multilineTextAlignment(.center)
            
            Button {
                self.isShowModal = true
            } label: {
                Text(self.btnTitle)
                    .font(.subheadRegular)
                    .tint(.white)
            }
            .fullScreenCover(isPresented: $isShowModal) {
                if let user = SharedPreference.shared.cheeringCard {
                    if user.name.isEmpty {
                        NicknameView(isShowModal: $isShowModal)
                    } else {
                        NavigationView {
                            CardView(showModal: $isShowModal)
                        }
                    }
                } else {
                    NicknameView(isShowModal: $isShowModal)
                }
            }
            .frame(width: 320, height: 50, alignment: .center)
            .background(Color.primary)
            .cornerRadius(5)
            .shadow(color: .primary.opacity(0.5), radius: 2, x: 4, y: 4)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

extension GoToCardView {
    private func setTitle() {
        if let user = SharedPreference.shared.cheeringCard {
            if user.name.isEmpty {
                state = "?"
                title = "나의 playgrounds card\n뽑으러 가기"
            } else {
                state = CardType.cardImage(type: user.cardType)
                title = "\(user.cardType)인 \(user.name)님,\n전체 결과를 확인해보세요!"
            }
        } else {
            state = "?"
            title = "나의 playgrounds card\n뽑으러 가기"
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
            if state == "?" {
                Text(state)
                    .font(.bodyRegular)
                    .frame(width: 40, height: 55)
                    .background(Color.white)
                    .cornerRadius(3)
                    .foregroundColor(.black)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
            } else {
                Image(state)
                    .resizable()
                    .frame(width: 40, height: 55)
                    .cornerRadius(3)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
            }
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
