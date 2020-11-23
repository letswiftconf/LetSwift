//
//  Shadow.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/23.
//

import SwiftUI

struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        return content
//            .shadow(color: Color.black.opacity(0.25), radius: 33)
            .shadow(radius: 4)
    }
}
