//
//  GustBookRow.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/06.
//

import SwiftUI

struct PlaygroundSimpleRow: View {
    let guestBook: GuestBookModel
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack(spacing: 20) {
                Image(systemName: guestBook.profile ?? "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70)
                
                Text(guestBook.content ?? "")
                
            }
        }
        .frame(height: 80)
    }
}
