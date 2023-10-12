import SwiftUI

//@available(iOS 16.1, *)
struct SessionFloatingButton: View {
    @State private var animationAmount: CGFloat = 1
    @ObservedObject var notifier: EventMessenger = EventMessenger()
    private let informationTextString1: String =
    """
    스노클링을 해보신 경험이 있으신가요?

    바닷속에는 우리가 보지 못했던 미지의 세계가

    끝도 없이 펼쳐져 있습니다.
    """

    private let informationTextString2: String =
    """
    직접 들어가 보지 않으면 알 수 없는 세계를 탐험해 봤던 경험을
    나누는 것은 우리의 지식과 경험을 더욱 풍부하게 만들 뿐 아니라
    공유의 가치를 더해 줄 것입니다.

    이제 Deep dive 할 시간입니다!
    함께하시죠 into the unknown으로!

    조심하세요!
    너무 깊이 들어갔다간 헤어 나오지 못할지도 모릅니다!

    """
    init(){
        
    }
    var body: some View {
        ZStack {
            Button(action: {
                notifier.isPressed = !notifier.isPressed
                print(notifier.isPressed)
            }, label: {
                Image("ic_floating")
            })
            
            if notifier.isPressed {
                VStack {
                    Spacer()
                    VStack(spacing: 22) {
                        Text(self.informationTextString1)
                            .font(.body1b)
                            .foregroundColor(.text)
                            .multilineTextAlignment(.center)

                        Text(self.informationTextString2)
                            .font(.body4b)
                            .foregroundColor(.subtext)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                    .padding(.top, 24)
                    LottieView(filename: "deepdive",notifier: notifier)
                        .opacity(Double(2 - animationAmount))
                        .rotation3DEffect(.degrees(360), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 0.5).delay(2),value: animationAmount)
                    Spacer()
                }
                .background(Color.backgroundBlack)
            }
        }
        
        /*
         라이브 액티비티 기능 활성화시 사용
        Button(action: store.buttonTapped) {
            Image("ic_floating")
                    .background(viewModel.getBackgroundColor(store.state.isLiveActivityVisible))
        }
        .padding(.trailing, -8)
        .alert(
            "알림",
            isPresented: .constant(store.state.error != nil)
        ) {
            Button(action: { store.state.error = nil }) {
                Text("확인")
            }
        } message: {
            Text(store.state.error?.localizedDescription ?? "잠시 후 다시 시도해주세요.")
        }
         */
    }
}

//struct SessionFloatingButton_Previews: PreviewProvider {
//    static var previews: some View {
//        if #available(iOS 16.1, *) {
//            SessionFloatingButton(store: .live)
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//}
//
