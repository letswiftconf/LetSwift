//
//  CardView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/08.
//

import SwiftUI



struct CardView: View {
    
#warning("Loading(Lottie), 공유")
    
    @Binding var isShowModal: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @State var isShowAlert = false
    var category: String?
    var name: String?

    init(showModal: Binding<Bool>) {
        self._isShowModal = showModal
        userData()
    }
    
    var body: some View {
        VStack {
            cardView
                .foregroundColor(.white)
            Text("#letswift #렛츠스위프트 @letswift를 태그해서 \n이미지를 공유하면 추첨해서 굿즈를 드립니다. ")
                .font(.subheadRegular)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            NavigationLink {
                ChartView()
            } label: {
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
                    Spacer()
                    Text("참가자 전체 결과 보기")
                        .font(.title3Reqular)
                        .foregroundColor(.white)
                    Spacer()
                }
                
            }
            .padding(10)
            .background(gradationBox())
            .foregroundColor(.black)
            .cornerRadius(8)
            .padding(.top, 10)
            
            HStack {
                Button {
                    let image = captureView
                        .foregroundColor(.black).snapshot()
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    isShowAlert = true
                } label: {
                    boxText(title: "이미지 저장", image: "arrow.down.to.line")
                }
                Spacer()
                Button {
                    let image = captureView
                        .foregroundColor(.black).snapshot()
                    shareImage(image: image)
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
            .padding(.top, 10)
            //TODO: Add Retry Button
            Button {
                print("다시 뽑기 click")
            } label: {
                Spacer()
                HStack {
                    Image(systemName: "goforward")
                        .foregroundColor(.textGray)
                        .frame(width: 10, height: 10)
                    Text("다시 뽑기")
                        .font(.footnote)
                        .foregroundColor(.textGray)
                }
                .padding(.top,10)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundBlack)
        .navigationTitle("")
        .toolbar {
#warning("Close dismiss 구현")
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
        }
        .alert(isPresented: $isShowAlert) {
            return Alert(title: Text("사진이 저장되었습니다!"), message: nil, dismissButton: .cancel(Text("확인")))
        }
    }
}

extension CardView {
    private mutating func userData() {
        guard let user = SharedPreference.shared.cheeringCard else {
            return
        }
        self.name = user.name
        self.category = user.category
    }
    
    private var cardView: some View {
        VStack {
            Image("CheeringCard")
                .resizable()
                .scaledToFit()
            HStack {
                // TODO: 밑줄 구현
                Text("\(category ?? "") \(name ?? "")님! \n Playground에서 함께 놀아요")
                    .font(.title3Bold)
                    .bold()
                    .padding(.leading, 10)
                    .padding(.top, 10)
                Spacer()
            }
        }
    }
    private var captureView: some View {
        VStack {
            cardView
                .padding(.bottom, 40)
        }
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
        .background(Color.backgroundCell)
        .cornerRadius(5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
