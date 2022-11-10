//
//  CardItem.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct GoToCardView: View {
    
    @State private var showModal = false
    
    var body: some View {
        Button {
            self.showModal = true
        } label: {
            HStack {
                Text("?")
                    .font(.title3)
                    .bold()
                    .frame(width:35, height: 50)
                    .background(Color.black)
                    .cornerRadius(3)
                Text("나의 playground card 뽑으러 가기")
                    .foregroundColor(Color.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $showModal, content: NicknameView.init)
    }
}


struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        GoToCardView()
    }
}
