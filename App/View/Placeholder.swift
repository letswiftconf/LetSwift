//
//  Placeholder.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//


// TODO: Remove this view

import SwiftUI

struct Placeholder: View {
    var body: some View {
        Rectangle()
            .modifier(RoundedMask())
            .foregroundColor(.gray)
            .frame(height: 200)
            .padding(.horizontal)
    }
}

// MARK: - Preview
struct Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        Placeholder()
            .previewAsComponent()
    }
}
