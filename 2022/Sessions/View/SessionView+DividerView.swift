//
//  SessionView+DividerView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

extension SessionView {
  struct DividerView: View {
    private let height: CGFloat
    
    init(height: CGFloat) {
      self.height = height
    }
    
    var body: some View {
      Rectangle()
        .foregroundColor(.orange)
        .frame(height: height)
    }
  }
}
