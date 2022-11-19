//
//  Modifier.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/17.
//

import UIKit
import SwiftUI

struct WillAppearHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> WillAppearHandler.Coordinator {
        Coordinator(onWillAppear: onWillAppear)
    }

    let onWillAppear: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<WillAppearHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<WillAppearHandler>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onWillAppear: () -> Void

        init(onWillAppear: @escaping () -> Void) {
            self.onWillAppear = onWillAppear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillAppear (_ animated: Bool) {
            super.viewWillAppear(animated)
            onWillAppear()
        }
    }
}

struct WillAappearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(WillAppearHandler(onWillAppear: callback))
    }
}

extension View {
    func onWillAappear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(WillAappearModifier(callback: perform))
    }
}
