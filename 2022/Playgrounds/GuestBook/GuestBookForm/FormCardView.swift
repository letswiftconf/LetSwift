//
//  FormCardView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/08.
//

import SwiftUI

struct FormCardView: View {
    
    enum FocusField: Hashable {
      case field
    }
    let card: FormCard
    var removal: ((String) -> Void)? = nil
    @State var content: String = ""
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    @State var currentIndex: Int = 0
    @State private var angle: CGFloat = 5
    @FocusState private var focused: FocusField?
    
    @Environment(\.colorScheme) var scheme

    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25,style: .circular)
                    .fill(.white)
                    .shadow(radius: 5)
                
                ZStack(alignment: .topLeading) {
                    if content.isEmpty {
                        Text(card.description)
                            .font(.title3Reqular)
                            .padding(EdgeInsets(top: 21, leading: 21, bottom: 0, trailing: 0))
                            .foregroundColor(.gray)
                    }
                    if #available(iOS 16.0, *) {
                        TextEditor(text:  $content)
                            .replaceDisabled()
                            .findDisabled()
                            .padding()
                            .foregroundColor(Color.black)
                            .textFieldStyle(.roundedBorder)
                            .cornerRadius(10)
                            .opacity(0.6)
                            .scrollContentBackground(.hidden)
                            .focused($focused,equals: .field)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            
                    } else {
                        // Fallback on earlier versions
                        TextEditor(text:  $content)
                            .padding()
                            .foregroundColor(Color.orange)
                            .colorMultiply(.gray)
                            .textFieldStyle(.roundedBorder)
                            .cornerRadius(10)
                            .focused($focused,equals: .field)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                    }
                }
                .padding()
                .multilineTextAlignment(.leading)
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
        }
        .onTapGesture{
            editTextEnd()
        }.onAppear{
            self.focused = .field
            if #available(iOS 16.0, *) {
                //'#unavailable' it can use upper swift 5.6
            }else{
                UITextView.appearance().backgroundColor = .clear
            }
     
            
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
