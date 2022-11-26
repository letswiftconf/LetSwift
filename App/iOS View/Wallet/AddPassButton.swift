//
//  AddPassButton.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/30.
//

import SwiftUI
import PassKit

struct AddPassButton: UIViewRepresentable {
    func makeUIView(context: Context) -> PKAddPassButton {
        let button = PKAddPassButton(addPassButtonStyle: .black)
        return button
    }
    
    func updateUIView(_ uiView: PKAddPassButton, context: Context) {
        
    }
}

// MARK: - Preview
struct AddPassButton_Previews: PreviewProvider {
    static var previews: some View {
        return AddPassButton()
            .frame(width: 320, height: 60)
            .previewAsComponent()
    }
}
