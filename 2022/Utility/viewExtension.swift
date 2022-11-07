//
//  viewExtension.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/07.
//

import SwiftUI

/// ex. Rsctangle()
/// .fill ( LinearGradient.gradientOrange.opacity(0.45))
extension LinearGradient {
    static let gradientOrange = LinearGradient(
        gradient: Gradient(
            colors: [.gradientStart, .gradientEnd]
        ),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}
