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
                            Text("@letswift  #letswift  #렛츠스위프트")
                                .font(.subheadBold)
                                .foregroundColor(.black)
                                .opacity(Double(animationAmount-1))
                                .animation(.easeIn(duration: 1).delay(3.5),value: animationAmount)
                            Text("인스타에 위의 태그를 걸어 게시물을 올려주세요!\n경품 추천 시간에 컨퍼런스 참여자를 대상으로 선물을 드립니다!")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .frame(height: 60)
                                .multilineTextAlignment(.center)
                                .opacity(Double(animationAmount-1))
                                .animation(.easeIn(duration: 1).delay(3.5),value: animationAmount)
                        }
                        .padding(.top, 5)
                        LottieView(filename: "tada")
                            .opacity(Double(2 - animationAmount))
                            .rotation3DEffect(.degrees(360), axis: (x: 0, y: 1, z: 0))
                            .animation(.easeOut(duration: 0.5).delay(2),value: animationAmount)
                    }
                    
                    NavigationLink {
                        ChartView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Spacer()
                            Text("참가자 전체 결과 보기")
                                .font(.title3Reqular)
                                .foregroundColor(.backgroundBlack)
                            Spacer()
                        }
                    }
                    .padding(10)
                    .background(.white)
                    .cornerRadius(5)
                    .frame(height: 50)
                    .padding(.top, 10)
                    .opacity(Double(animationAmount-1))
                    .animation(.easeIn(duration: 1).delay(3.5),value: animationAmount)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 3, y: 3)
                    HStack {
                        Button {
                            UIImageWriteToSavedPhotosAlbum(captureImage(), nil, nil, nil)
                            isShowAlert = true
                        } label: {
                            boxText(title: "이미지 저장", image: "arrow.down.to.line")
                        }
                        Spacer()
                        Button {
                            shareImage(image: captureImage())
                        } label: {
                            boxText(title: "카드 공유", image: "square.and.arrow.up")
                        }
                        Spacer()
                        Button {
                            // action
                        } label: {
                            boxText(title: "동료 찾기", image: "magnifyingglass")
                        }
                    }
                    .opacity(Double(animationAmount-1))
                    .animation(.easeIn(duration: 1).delay(3.5),value: animationAmount)
                    .padding(.top, 15)
                    
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
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                        .opacity(Double(animationAmount-1))
                        .animation(.easeIn(duration: 1).delay(3.5),value: animationAmount)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
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
        SharedPreference.shared.cheeringCard = CheeringCardModel(name: user.name, cardType: user.cardType, image: imageData)
    }
    
    private var cardView: some View {
        ZStack {
            Image(CardType.cardImage(type: self.category!))
                .resizable()
                .scaledToFit()
                .frame(width: 330, height: 400)
                .shadow(color: .black.opacity(0.6), radius: 5, x: 4, y: 3)
            VStack(spacing:0) {
                Spacer()
                VStack(spacing:0){
                    HStack {
                        Text("Let’Swift 2022")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                        Spacer()
                    }
                    HStack(spacing: 0) {
                        Text("\(category ?? "")")
                            .font(.title)
                        Text("인")
                            .font(.system(size: 25))
                            .fontWeight(.light)
                        
                        Spacer()
                    }
                    .frame(height:33)
                    .padding(.top, 10)
                    HStack(spacing: 0) {
                        Text("\(name ?? "")")
                            .font(.title)
                        Text("님")
                            .font(.system(size: 25))
                            .fontWeight(.light)
                            .padding(.top, 2)
                        Spacer()
                    }
                    .frame(height:33)
                    HStack {
                        Text("PLAYGROUND에서 함께 놀아요")
                            .font(.system(size: 16))
                            .fontWeight(.light)
                            .foregroundColor(Color.cardTextGray)
                        Spacer()
                    }
                    .padding(.top, 10)
                }
                .padding(.leading, 28)
                .padding(.bottom, 35)
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
        .background(Color.orange)
    }
    
    private func shareImage(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        let viewController = Coordinator.topViewController()
        activityViewController.popoverPresentationController?.sourceView = viewController?.view
        viewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    private enum Coordinator {
        static func topViewController(
            _ viewController: UIViewController? = nil
        ) -> UIViewController? {
            let vc = viewController ?? UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController
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
        .background(Color.backgroundBlack)
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
