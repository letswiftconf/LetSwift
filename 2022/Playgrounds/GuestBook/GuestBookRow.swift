//
//  GustBookRow.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/06.
//

import SwiftUI

struct PlaygroundSimpleRow: View {
    let guestBook: GuestBook
    
    var body: some View {
        HStack {
            Text("?")
                .font(.title3)
                .bold()
                .frame(width:35, height: 50)
                .background(Color.orange)
                .cornerRadius(3)
            Text(guestBook.contents ?? "")
                .foregroundColor(Color.white)
                .padding(.leading)
            Spacer()
        }
        .padding()
        .cornerRadius(10)
        
        
    }
}
