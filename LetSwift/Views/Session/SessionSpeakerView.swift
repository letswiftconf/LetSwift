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
            Group {
                if let url = URL(string: imageUrl) {
                    CachedImage(url: url, content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                    }, placeholder: {
                        placeholder
                    })
                } else {
                    placeholder
                }
            }
            .frame(width: 24, height: 24)
            .cornerRadius(4)
            
            Text(LocalizedStringKey(name))
                .font(.system(size: 10))
        }
    }
    
    private var placeholder: some View {
        Color.gray9
    }
}

#Preview {
    SessionSpeakerView(name: "연사자", imageUrl: "https://picsum.photos/600/400")
}
