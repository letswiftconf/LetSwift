//
//  ProfileImageView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/08.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ProfileImageView: View {
    let imageName: String
    
    // MARK: - Body
    var body: some View {
        let backgroundColor = Color(.systemBackground)
        let borderColor = Color(.separator)
        let shape = Circle()
        return Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .background(backgroundColor) // Because some uses PNG
            .overlay(shape.stroke(borderColor, lineWidth: 1))
            .clipShape(shape)
    }
}

// MARK: - Preview
struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileImageView(imageName: "Sample")
            ProfileImageView(imageName: "구범모")
            ProfileImageView(imageName: "김나용")
            ProfileImageView(imageName: "이태현(Jake)")
        }
        .frame(width: 200, height: 200)
        .padding()
        .background(Color(.systemBackground))
//        .environment(\.colorScheme, .dark)
        .previewLayout(.sizeThatFits)
    }
}
