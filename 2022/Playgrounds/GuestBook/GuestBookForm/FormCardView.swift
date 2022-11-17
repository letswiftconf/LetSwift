//
//  FormCardView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/08.
//

import SwiftUI

struct FormCardView: View {
    
    let card: FormCard
    var removal: ((String) -> Void)? = nil
    @State var content: String = ""
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    @State var currentIndex: Int = 0
    @State private var angle: CGFloat = 5
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25,style: .circular)
                    .fill(.white)
                    .shadow(radius: 10)
                
                VStack {
                    Text(card.description)
                        .font(.title3Reqular)
                        .foregroundColor(.gray)
                    
                    TextEditor(text:  $content)
                        .padding()
                        .foregroundColor(Color.orange)
                        .background(Color.textGray)
                        .cornerRadius(10)
                        .shadow(radius: 1)
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
                            removal?(content)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FormCardView(card: FormCard.example)
    }

}
