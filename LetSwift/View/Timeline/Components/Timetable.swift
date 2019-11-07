//
//  Timetable.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/15.
//  Copyright © 2019 gbmksquare. All rights reserved.
//

import SwiftUI

struct Timetable<Content>: View where Content: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("탭 또는 스와이프로 타임라인을 변경하세요.")
                .font(.system(size: 10))
                .foregroundColor(.secondary)
//                .padding(.leading)
            HStack {
                content()
            }
        }
    }
}

struct Timetable_Previews: PreviewProvider {
    static var previews: some View {
        Timetable {
            TimeAxis(hours: 9...17, hourHeight: 80, hourSpacing: 16)
            TimetableContainer {
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
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .previewLayout(.sizeThatFits)
    }
}
