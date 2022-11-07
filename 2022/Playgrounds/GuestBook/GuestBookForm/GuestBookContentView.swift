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
        return self.offset(x: 0,y: offset - 10)
    }
}

struct GuestBookContentView: View {
    
    @State private var cards = Array<FormCard>(repeating: FormCard.example, count:10)
    @State private var scale: CGFloat = 0.020
    @State private var angle: CGFloat = 5
    
    var body: some View {
        ZStack {
            VStack{
                LottieView(filename: "arrow-up")
                    .frame(height: 50)
                
                Text("Slide up to send your message")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                ZStack{
                    ForEach(0..<cards.count,id: \.self) { index in
                        FormCardView(card: cards[index]).stack(at: index, in: cards.count)
                    }
                }
            }
        }
    }
}

struct GuestBookContentView_Previews: PreviewProvider {
    static var previews: some View {
        GuestBookContentView()
    }
}
