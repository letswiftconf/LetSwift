//
//  SessionView+GradientButton.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

extension SessionView {
    struct OrangeButton: View {
        private let textString: String
        private let action: () -> Void
        
        init(textString: String, action: @escaping () -> Void) {
            self.textString = textString
            self.action = action
        }
        
        var body: some View {
            Button(
                action: { self.action() },
                label: {
                    Text(self.textString)
                        .font(.caption2Regular)
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.orange)
                        .cornerRadius(20)
                }
            )
        }
    }

    struct SmallBoxButton: View {
        private let textString: String
        private let action: () -> Void
        private let color: Color

        init(textString: String, action: @escaping () -> Void, color: Color = .white) {
            self.textString = textString
            self.action = action
            self.color = color
        }

        var body: some View {
            Button(
                action: { self.action() },
                label: {
                    Text(self.textString)
                        .font(.body4r)
                        .foregroundColor(.primary)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 7)
                        .background(Color.title)
                        .cornerRadius(5)
                }
            )
            .shadow(color: .white.opacity(0.25), radius: 2, x: 0, y: 4)
        }
    }

}

extension SessionView.OrangeButton: Identifiable {
    var id: UUID { return UUID() }
}

extension SessionView.SmallBoxButton: Identifiable {
    var id: UUID { return UUID() }
}

