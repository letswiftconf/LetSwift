//
//  SessionView+GradientButton.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

extension SessionView {
  struct GradientButton: View {
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
}

extension SessionView.GradientButton: Identifiable {
  var id: UUID { return UUID() }
}
