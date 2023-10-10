//
//  LottieView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/08.
//

import SwiftUI
import UIKit
import Lottie

class EventMessenger: ObservableObject {
    @Published var isPressed: Bool = false
}

struct LottieView : UIViewRepresentable {
    var filename = "arrow-up"
    typealias UIViewType = UIView
    
    private var notifier: EventMessenger = EventMessenger()
    
    init(filename: String = "arrow-up", notifier: EventMessenger = EventMessenger()) {
        self.filename = filename
        self.notifier = notifier
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)


        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        animationView.play  { finished in
            notifier.isPressed = !finished
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }

}
