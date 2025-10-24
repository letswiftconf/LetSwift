//
//  SessionSpeakerView.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
//

import SwiftUI

struct SessionSpeakerView: View {
    let name: String
    let imageUrl: String
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: 24, height: 24)
            .cornerRadius(4)
            
            Text(LocalizedStringKey(name))
                .font(.system(size: 10))
        }
    }
}

#Preview {
    SessionSpeakerView(name: "연사자", imageUrl: "https://picsum.photos/600/400")
}
