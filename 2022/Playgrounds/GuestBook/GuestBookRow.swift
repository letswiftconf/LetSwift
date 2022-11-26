//
//  GustBookRow.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/06.
//

import SwiftUI

struct PlaygroundSimpleRow: View {
    let guestBook: GuestBook
    var viewModel = PlaygroundSimpleRowViewModel()
    var body: some View {
        HStack {
            Image(viewModel.getRandomImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50,height: 50)
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
