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

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
}
