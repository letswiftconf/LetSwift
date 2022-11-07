//
//  GuestBookContainerView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/01.
//

import SwiftUI

struct GuestBookContainerView: View {
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Let' play \nat Swift Playgrounds")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                MyPlaygrounds()
                
                Section(header: Text("우리들의 기록")) {
                    ForEach(GuestBooksModel.mockingData, id: \.id) { event in
                        PlaygroundSimpleRow(guestBook: event)
                    }
                }
            }
            .padding()
        }
        .padding(.top, 1)
        
    }
}

struct GuestBookContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GuestBookContainerView()
    }
}
