//
//  GoToGuestBookFormView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/11.
//

import SwiftUI
import RxSwift
import RxRelay


struct GoToGuestBookFormView: View {
    @EnvironmentObject var env:GuestBookEnviromentOjb
    
    struct Action {
        var send = PublishRelay<Void>()
        var guestBookList = PublishRelay<Void>()
    }
    var action = Action()

    var disposeBag = DisposeBag()
    var contents: [GuestBook] = []
    
    
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
                Text(env.userContent)
                    .foregroundColor(Color.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
            }
            .padding()
            .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $showModal) {
            print("dismiss")
        } content: {
            GuestBookContentView()
        }
    }
}

