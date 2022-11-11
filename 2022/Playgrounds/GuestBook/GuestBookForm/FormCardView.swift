//
//  FormCardView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/08.
//

import SwiftUI

struct FormCardView: View {
    let card: FormCard
    var removal: (() -> Void)? = nil
    @State var content: String = ""
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    @State var currentIndex: Int = 0
    @State private var angle: CGFloat = 5
    
    var body: some View {
        VStack {
            Spacer()
                
            ZStack {
                RoundedRectangle(cornerRadius: 25,style: .circular)
                    .fill(.white)
                    .shadow(radius: 10)
                VStack {
                    Text(card.answer)
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    TextField("하고싶은 말을 남겨주세요", text: $content)
                        .padding()
                }
                .padding()
                .multilineTextAlignment(.center)
            }
            .frame(height: 250)
            .padding([.leading,.trailing])
            .rotationEffect(.degrees(Double(offset.height / 5)))
            .offset(x: 0, y: offset.height * 5)
            .opacity(2 - Double(abs(offset.height / 50)))
            .accessibilityAddTraits(.isButton)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        feedback.prepare()
                    }
                    .onEnded { _ in
                        if abs(offset.height) > 100 {
                            removal?()
                            content = ""
                        } else {
                            offset = .zero
                        }
                    }
            )
            .animation(.spring(), value: offset)
            Spacer()
        }.onTapGesture{
            editTextEnd()
        }
        
    }
    
}


extension View {
    func editTextEnd(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
