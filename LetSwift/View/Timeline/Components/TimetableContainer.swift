//
//  TimetableContainer.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/15.
//  Copyright © 2019 gbmksquare. All rights reserved.
//

import SwiftUI

struct TimetableContainer<Content>: View where Content: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            content()
        }
    }
}

struct TimetableContainer_Previews: PreviewProvider {
    static var previews: some View {
        TimetableContainer() {
            TimelineGroup() {
                Timeline(isCollapsed: .constant(true)) {
                    TimeBlock(session: .dummy, color: .pink, height: 80)
                    Spacer()
                }
                Timeline(isCollapsed: .constant(false)) {
                    TimeBlock(session: .dummy, showContents: true, color: .pink, height: 80)
                    Spacer()
                }
                Timeline(isCollapsed: .constant(true)) {
                    TimeBlock(session: .dummy, color: .pink, height: 80)
                    Spacer()
                    TimeBlock(session: .dummy, color: .blue, height: 40)
                }
            }
            TimeBlock(session: .dummy, color: .yellow, height: 50)
                .offset(y: 90)
        }
        .padding()
        .frame(height: 220)
        .background(Color(.systemBackground))
        .previewLayout(.sizeThatFits)
    }
}
