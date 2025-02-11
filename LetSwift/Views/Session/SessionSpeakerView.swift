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
//            AsyncImage(url: URL(string: imageUrl)) { image in
//                image.resizable()
//            } placeholder: {
//                Color.gray
//            }
            Image(uiImage: UIImage(named: imageUrl) ?? UIImage())
                .resizable()
                .frame(width: 24, height: 24)
                .clipShape(Circle())
            
            Text(LocalizedStringKey(name))
                .font(.regular(size: 12))
                .foregroundColor(.gray8)
        }
    }
}
