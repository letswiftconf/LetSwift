//
//  GuestBookContentView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/08.
//

import SwiftUI
import RxSwift

extension View {
    func stack(at position: Int , in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0,y: offset * 10)
    }
}

struct GuestBookContentView: View {

    @State private var cards = Array<FormCard>(repeating: FormCard.example, count:10)
    @State private var scale: CGFloat = 0.020
    @State private var angle: CGFloat = 5
    @State private var guideText: String = "작성한 카드를 위로 밀어서 보내주세요."
    @State private var isSent: Bool = false
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var env:GuestBookEnviromentOjb
    var viewModel = GuestBookContentViewModel()
    var disposeBag = DisposeBag()
    
    var body: some View {
        ZStack (alignment: .top){
            Text("방명록 남기기")
                .font(.bodyRegular)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top)
                .zIndex(1)
            
            VStack (spacing: 0) {
                VStack (alignment: .leading , spacing: 0 ){
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .frame(width: 50,height: 50)
                    
                    
                    if isSent {
                        LottieView(filename: "arrow-up")
                            .frame(height: 200)
                    }else{
                        LottieView(filename: "arrow-up")
                    }
                        
                }
                VStack(spacing: 40) {
                    if isSent {
                        VStack (alignment: .leading) {
                            Text("🎉🎉")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                            TitleView()
                        }
                    }
                    Text(guideText)
                        .font(guideText == "작성한 카드를 위로 밀어서 보내주세요." ? .title3: .title3Reqular)
                        .foregroundColor(.white)
                }
                if !isSent {
                    ZStack{
                        ForEach(0..<cards.count,id: \.self) { index in
                            FormCardView(card: cards[index]){ content in
                                withAnimation {
                                    removeCard(at: index, content: content)
                                }
                            }.stack(at: index, in: cards.count)
                        }
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .background(Color.backgroundBlack)
            .onTapGesture {
                self.editTextEnd()
            }
            .onAppear{
                self.setupRX()
                
            }
        }
    }
    
    func setupRX(){
        viewModel.state.receive
            .subscribe(onNext: { success in
                env.contents = viewModel.contents
                if success {
                    env.isSuccess = true
                    UIView.animate(withDuration: 2, delay: 5, usingSpringWithDamping: 0.0, initialSpringVelocity: 0) {
                        isSent = true
                        guideText = "후기를 남겨주셔서 감사합니다."
                    }completion: { _ in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            UIView.animate(withDuration: 0.4, delay: 0, options: .showHideTransitionViews) {
                                dismiss()
                            }
                        }
                    }
                }else{
                    Toast.shared.show(message: self.viewModel.getMessage(success: success), delay: 1.5){ _ in
                        dismiss()
                    }
                }
                
            })
            .disposed(by: disposeBag)
    }
    
    func removeCard(at index: Int, content: String) {
        cards.remove(at: index)
        if !content.isEmpty {
            env.userContent = content
            self.viewModel.setContents(content)
            self.viewModel.action.send.accept(())
        }else{
            if cards.count == 0 {
                Toast.shared.show(message: "다음에는 꼭! 남겨주시기에요~", delay: 1.5){ _ in
                    if cards.isEmpty {
                        dismiss()
                    }
                }
            }else if cards.count < 10 && cards.count > 5 {
                Toast.shared.show(message: "슝슝~ 카드 날리기 재밌죠~\n방명록과 함께 날리면 더 재밌어요~", delay: 1.5)
            }else{
                Toast.shared.show(message: "이제 카드가 몇 장 남지않았어요~", delay: 1.5)
            }
        }
        
    }
}

struct GuestBookContentView_Previews: PreviewProvider {
    static var previews: some View {
        GuestBookContentView()
    }
}
