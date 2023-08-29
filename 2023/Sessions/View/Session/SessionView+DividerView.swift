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
        private let color: Color
        
        init(height: CGFloat, color: Color) {
            self.height = height
            self.color = color
        }
        
        var body: some View {
            Rectangle()
                .foregroundColor(self.color)
                .frame(height: self.height)
        }
    }
}
