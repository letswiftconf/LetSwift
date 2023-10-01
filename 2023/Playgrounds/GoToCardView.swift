//
//  CardItem.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI


struct Item: Identifiable {
    var id: Int
    var title: String
    var color: String
    var session: String
}

class Store: ObservableObject {
    @Published var items: [Item]
    
    let colors: [String] = ["cardGreen","cardRed","primary","cardYellow","cardGreen","cardRed","primary","cardYellow","cardGreen","cardRed"]
    
    let titles: [String] = ["🎨미적감각왕🎨","🍎애플왕🍎","💻신기술왕💻","🙌소통왕🙌","🎨미적감각왕🎨","🍎애플왕🍎","💻신기술왕💻","🙌소통왕🙌","🎨미적감각왕🎨","🍎애플왕🍎"]
    
    let sessions: [String] = ["요즘 유행하는 AI에 진심인","모듈모듈 모듈화에 진심인","새로운 패러다임 스유에 진심인","Swift 파고드는 것에 진심인","공장장이 되고싶어! 생산성에 진심인","매크로에 진심인","Bluetooth에 진심인","Segue에 진심인","의존성에 진심인","Metal에 진심인"]
    // dummy data
    init() {
        items = []
        for i in colors.indices {
            let new = Item(id: i, title: "\(titles[i])", color: colors[i], session: sessions[i])
            items.append(new)
        }
    }
}

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
    
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State private var animationAmount: CGFloat = 1
    
    @State private var currentIndex = 0
    
    var body: some View {
//        ScrollView(showsIndicators: false) {
            VStack {
                Text("Deep Dive Card")
                    .font(.head1b)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                ZStack {
                    ForEach(store.items) { item in
                        ZStack {
                            Rectangle()
                                .fill(getCardColor(type: item.color))
                                .frame(width: 300, height: 385)
                                .cornerRadius(20)
                                .animation(.easeIn(duration: 1).delay(2.5),value: animationAmount)
                            Image("back_cheercard")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 280, height: 350)
                                .shadow(color: .black.opacity(0.6), radius: 5, x: 4, y: 3)
                            
                            VStack(spacing:0) {
                                VStack(spacing:0){
                                    HStack(spacing: 0) {
                                        Spacer()
                                        Text(item.session)
                                            .font(.head3b)
                                        Spacer()
                                    }
                                    .frame(height:33)
                                    .padding(.top, 10)
                                    HStack(spacing: 0) {
                                        Spacer()
                                        Text("OOO 님")
                                            .font(.head3b)
                                        Spacer()
                                    }
                                    .frame(height:33)
                                }
                                .padding(.top, 35)
                                Spacer()
                                Image("content_cheercard")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.bottom, 15)
                            }
                        }
                        .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
                        .opacity(1.0 - abs(distance(item.id)) * 0.3 )
                        .offset(x: myXOffset(item.id), y: 0)
                        .zIndex(1.0 - abs(distance(item.id)) * 0.1)
                    }
                }
                .frame(width: 280, height: 350)
                .padding(.bottom, 35)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            draggingItem = snappedItem + value.translation.width / 700
                            print(draggingItem)
                        }
                        .onEnded { value in
                            withAnimation {
                                draggingItem = snappedItem + value.predictedEndTranslation.width / 700
                                print(draggingItem)
                                draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                                print(draggingItem)
                                snappedItem = draggingItem
                            }
                        }
                )
                
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
            . onAppear {
                let timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
                    currentIndex = (currentIndex + 1) % store.items.count
                }
                RunLoop.main.add(timer, forMode: .common)

            }
        
        
        
//        }
    }
    
    private func getCardColor(type: String) -> Color {
        return Color(type)
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
        return sin(angle) * 300
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
