//
//  CardView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/08.
//

import SwiftUI

struct CardView: View {
    
    @Binding var isShowModal: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @State var isShowAlert = false
    @State private var animationAmount: CGFloat = 1
    
    var category: String?
    var name: String?
    var session: String?
    
    private let sessionDescription: String =
    """
    직접 들어가 보지 않으면 알 수 없는 세계를
    
    탐험해 봤던 경험을 나누는 것은
    우리의 지식과 경험을 더욱 풍부하게 만들 뿐 아니라
    공유의 가치를 더해 줄 것입니다.
    
    이제 Deep dive 할 시간입니다!
    함께하시죠 into the unknown으로!
    
    조심하세요!  
    너무 깊이 들어갔다간 헤어 나오지 못할지도 모릅니다!
    """
    
    init(showModal: Binding<Bool>) {
        self._isShowModal = showModal
        userData()
    }
    
    var body: some View {
        VStack (spacing:0){
            HStack {
                Button {
                    isShowModal = false
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 18)
                }
                .padding(15)
                .opacity(Double(animationAmount-1))
                .animation(.easeIn(duration: 1).delay(3.5),value: animationAmount)
                Spacer()
            }
            ScrollView {
                VStack {
                    ZStack {
                        VStack(spacing:0){
                            cardView
                                .padding(.top, 20)
                                .padding(.bottom,20)
                                .opacity(Double(animationAmount-1))
                                .animation(.easeIn(duration: 1).delay(2.5),value: animationAmount)
                            Text("\(self.sessionDescription)")
                                .font(.body4r)
                                .foregroundColor(.subtext)
                                .multilineTextAlignment(.center)
                                .opacity(Double(animationAmount-1))
                                .animation(.easeIn(duration: 1).delay(3.5),value: animationAmount)
                                .padding(.top, 15)
                        }
                        .padding(.top, 5)
                        LottieView(filename: "tada")
                            .opacity(Double(2 - animationAmount))
                            .rotation3DEffect(.degrees(360), axis: (x: 0, y: 1, z: 0))
                            .animation(.easeOut(duration: 0.5).delay(2),value: animationAmount)
                    }
                    HStack {
                        Button {
                            UIImageWriteToSavedPhotosAlbum(captureImage(), nil, nil, nil)
                            isShowAlert = true
                        } label: {
                            boxText(title: "이미지 저장", image: "arrow.down.to.line")
                        }
                        .frame(width: 170, height: 28)
                        .cornerRadius(5)
                        
                        Spacer()
                        Button {
                            shareImage(image: captureImage())
                        } label: {
                            boxText(title: "카드 공유", image: "square.and.arrow.up")
                        }
                        .frame(width: 170, height: 28)
                        .cornerRadius(5)
                        Spacer()
                    }
                    
                    .opacity(Double(animationAmount-1))
                    .animation(.easeIn(duration: 1).delay(3.5),value: animationAmount)
                    .shadow(color: .primary.opacity(0.5), radius: 2, x: 4, y: 4)
                    
                    
                    Button {
                        isShowModal = false
                        SharedPreference.shared.remove()
                    } label: {
                        Spacer()
                        HStack {
                            Image(systemName: "goforward")
                                .foregroundColor(.white)
                                .frame(width: 10, height: 10)
                            Text("다시 뽑기")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .opacity(Double(animationAmount-1))
                        .animation(.easeIn(duration: 1).delay(3.5),value: animationAmount)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg)
        .navigationTitle("")
        .alert(isPresented: $isShowAlert) {
            return Alert(title: Text("사진이 저장되었습니다!"), message: nil, dismissButton: .cancel(Text("확인")))
        }
        .onAppear{
            self.animationAmount += 1
        }
        .onDisappear(){
            saveImage()
        }
    }
    
    
}

extension CardView {
    
    private mutating func userData() {
        guard let user = SharedPreference.shared.cheeringCard else {
            return
        }
        self.name = user.name
        self.category = user.cardType
        self.session = user.sessionType
    }
    
    private func captureImage() -> UIImage {
        let image = captureView
            .foregroundColor(.white).snapshot()
        return image
    }
    
    private func saveImage() {
        let imageData = captureImage().pngData()!
        guard let user = SharedPreference.shared.cheeringCard else {
            return
        }
        SharedPreference.shared.cheeringCard = CheeringCardModel(name: user.name, cardType: user.cardType, image: imageData, sessionType: user.sessionType)
    }
    
    private var cardView: some View {
        ZStack {
            
            Rectangle()
                .fill(getCardColor(type: self.category ?? ""))
                .frame(width: 350, height: 435)
                .cornerRadius(20)
                .animation(.easeIn(duration: 1).delay(2.5),value: animationAmount)
            
            //            Image(CardType.cardImage(type: self.category!))
            Image("back_cheercard")
                .resizable()
                .scaledToFit()
                .frame(width: 330, height: 400)
                .shadow(color: .black.opacity(0.6), radius: 5, x: 4, y: 3)
            VStack(spacing:0) {
                VStack(spacing:0){
                    HStack(spacing: 0) {
                        Spacer()
                        Text("\(session ?? "")")
                            .font(.head3b)
                        Spacer()
                    }
                    .frame(height:33)
                    .padding(.top, 10)
                    HStack(spacing: 0) {
                        Spacer()
                        Text("\(category ?? "") ")
                            .font(.head3b)
                        Text("\(name ?? "")")
                            .font(.head3b)
                        Text("님")
                            .font(.body2b)
                            .padding(.top, 2)
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
        .frame(width: 330, height: 400)
    }
    
    private var captureView: some View {
        VStack {
            cardView
                .padding(20)
        }
        .padding(.bottom, 50)
        .background(Color.black.opacity(0.0))
        
    }
    
    private func shareImage(image: UIImage) {
        ShareManager.shareInstagrame(with: image)
    }
    
    //    private enum Coordinator {
    static func topViewController(
        _ viewController: UIViewController? = nil
    ) -> UIViewController? {
        let vc = viewController ?? UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController
        //            let vc = keyWindow?.rootViewController
        if let navigationController = vc as? UINavigationController {
            return topViewController(navigationController.topViewController)
        } else if let tabBarController = vc as? UITabBarController {
            return tabBarController.presentedViewController != nil ?
            topViewController(
                tabBarController.presentedViewController
            ) : topViewController(
                tabBarController.selectedViewController
            )
        } else if let presentedViewController = vc?.presentedViewController {
            return topViewController(presentedViewController)
        }
        return vc
    }
    
    
    private func getCardColor(type: String) -> Color {
        return Color((CardType.CardCase(rawValue: type) ?? .none).color)
    }
    
    @ViewBuilder func gradationBox() -> some View {
        Rectangle()
            .fill(LinearGradient.gradientOrange.opacity(0.45))
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
    }
    
    @ViewBuilder func boxText(title: String, image: String) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Image(systemName: image)
                .frame(width: 10, height: 10)
                .foregroundColor(.white)
            Text(title)
                .font(.footnote)
                .foregroundColor(.white)
                .cornerRadius(3)
            Spacer()
        }
        .frame(height: 35)
        .background(Color.primary)
        .cornerRadius(5)
    }
    
    @ViewBuilder func tagBox(title: String) -> some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.footnote)
                .foregroundColor(.white)
                .cornerRadius(3)
        }
        .frame(height: 35)
        .background(gradationBox())
        .cornerRadius(5)
    }
}


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}

var keyWindow: UIWindow? {
    let allScenes = UIApplication.shared.connectedScenes
    for scene in allScenes {
        guard let windowScene = scene as? UIWindowScene else { continue }
        for window in windowScene.windows where window.isKeyWindow {
            return window
        }
    }
    return nil
}
