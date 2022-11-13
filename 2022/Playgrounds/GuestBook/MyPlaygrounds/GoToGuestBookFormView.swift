//
//  GoToGuestBookFormView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/11.
//

import SwiftUI

struct GoToGuestBookFormView: View {
    
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
            .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $showModal, content: GuestBookContentView.init)
        
    }
}

