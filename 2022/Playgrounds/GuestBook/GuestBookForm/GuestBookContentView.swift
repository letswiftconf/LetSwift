//
//  GuestBookContentView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/08.
//

import SwiftUI

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
    @Environment(\.presentationMode) var presentationMode
    
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
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .frame(width: 50,height: 50)
                    
                    LottieView(filename: "arrow-up")
                }
                
                Text("작성한 카드를 위로 밀어서 보내주세요.")
                    .font(.title3Bold)
                    .foregroundColor(.gray)
                
                ZStack{
                    ForEach(0..<cards.count,id: \.self) { index in
                        FormCardView(card: cards[index]){ content in
                            withAnimation {
                                removeCard(at: index, content: content)
                            }
                        }.stack(at: index, in: cards.count)
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .background(Color.backgroundBlack)
        }
    }
    
    func removeCard(at index: Int, content: String) {
        cards.remove(at: index)
        if !content.isEmpty {
            Toast.shared.show(message: "후기를 남겨주셔서 감사합니다 :)", delay: 1.5){ _ in
                presentationMode.wrappedValue.dismiss()
            }
        }else{
            if cards.count == 0 {
                Toast.shared.show(message: "다음에는 꼭! 남겨주시기에요~", delay: 1.5){ _ in
                    if cards.isEmpty {
                        presentationMode.wrappedValue.dismiss()
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
