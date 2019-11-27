//
//  Timeline.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/15.
//  Copyright © 2019 gbmksquare. All rights reserved.
//

import SwiftUI

struct Timeline<Content>: View where Content: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Binding var isCollapsed: Bool

    var cornerRadius: CGFloat = 6
    let collapsedWidth: CGFloat = 12
    var sectionSpacing: CGFloat = 0

    var trackColor = Color(.secondarySystemBackground)

    let content: () -> Content

    // MARK: - Initialization
    init(isCollapsed: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._isCollapsed = isCollapsed
        self.content = content
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .frame(width: horizontalSizeClass == .regular ? nil : (isCollapsed ? collapsedWidth : nil))
        .background(trackColor)
        .mask(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }

}

// MARK: - Preview
struct Timeline_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                Timeline(isCollapsed: .constant(false)) {
                    TimeBlock(session: .dummy, showContents: true, color: .pink, height: 80)
                    Spacer()
                }
                Timeline(isCollapsed: .constant(false)) {
                    Spacer()
                    TimeBlock(session: .dummy, showContents: true, color: .pink, height: 120)
                }
                Timeline(isCollapsed: .constant(false)) {
                    Spacer()
                    TimeBlock(session: .dummy, showContents: false, color: .pink, height: 100)
                    TimeBlock(session: .dummy, showContents: false, color: .blue, height: 80)
                }
            }
            HStack {
                Timeline(isCollapsed: .constant(false)) {
                    TimeBlock(session: .dummy, showContents: true, color: .pink, height: 80)
                    Spacer()
                    TimeBlock(session: .dummy, showContents: true, color: .blue, height: 80)
                }
                Timeline(isCollapsed: .constant(false)) {
                    Spacer()
                    TimeBlock(session: .dummy, showContents: true, color: .green, height: 100)
                    Spacer()
                }
            }
            .environment(\.colorScheme, .dark)
            Timeline(isCollapsed: .constant(true)) {
                TimeBlock(session: .dummy, color: .pink, height: 80)
                Spacer()
                TimeBlock(session: .dummy, color: .green, height: 30)
                Spacer()
                TimeBlock(session: .dummy, color: .blue, height: 40)
            }
            Timeline(isCollapsed: .constant(true)) {
                TimeBlock(session: .dummy, color: .pink, height: 80)
                Spacer()
                TimeBlock(session: .dummy, color: .green, height: 30)
                Spacer()
                TimeBlock(session: .dummy, color: .blue, height: 40)
            }
            .environment(\.colorScheme, .dark)
        }
        .padding()
        .frame(height: 240)
        .background(Color(.systemBackground))
        .previewLayout(.sizeThatFits)
    }
}
