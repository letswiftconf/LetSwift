//
//  GustBookRow.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/06.
//

import SwiftUI

struct PlaygroundSimpleRow: View {
//    let guestBook: GuestBookModel
    let guestBook: WelcomeElement
    
    var body: some View {
        HStack (alignment: .top ) {
            Text("?")
                .font(.title3)
                .bold()
                .frame(width:35, height: 50)
                .background(Color.orange)
                .cornerRadius(3)
            Text(guestBook.name ?? "")
                .foregroundColor(Color.white)
                .padding(.leading)
            Spacer()
        }
        .padding()
        .cornerRadius(10)
        
        
    }
}
