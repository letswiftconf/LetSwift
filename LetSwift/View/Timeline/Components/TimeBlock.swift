//
//  TimeBlock.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/15.
//  Copyright © 2019 gbmksquare. All rights reserved.
//

import SwiftUI

struct TimeBlockSettings {
    var showContents = false
    var cornerRadius: CGFloat = 6
    var color: Color = .blue
}

struct TimeBlock: View {
    var session: ProtoSession
    
    var showContents = false
    var cornerRadius: CGFloat = 6
    var color = Color.blue
    
    var height: CGFloat?
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .foregroundColor(color)
                .frame(height: height)
            // Contents
            if showContents == true {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    if session.level != "" {
                        LevelIndicator(level: session.level, textColor: self.color)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(session.title)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                        Group {
                            if session.speaker != "" {
                                Text(session.speaker)
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                            }
                            if session.time != "" {
                                Text(session.time)
                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .foregroundColor(Color(#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)))
                        Spacer()
                    }
//                    Spacer()
//                    VStack {
//                        Text("🍵")
//                        Spacer()
//                    }
                }
                .foregroundColor(.white)
                .padding(6)
                .frame(maxHeight: height)
            }
        }
    }
}

// MARK: - Preview
extension TimeBlock {
    
}

struct TimeBlock_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                TimeBlock(session: .dummy, showContents: true, color: .pink, height: 80)
                TimeBlock(session: .dummy, showContents: true, color: .blue, height: 80)
            }
            HStack {
                TimeBlock(session: .dummy, showContents: true, color: .orange, height: 80)
                TimeBlock(session: .dummy, showContents: true, color: .green, height: 80)
                TimeBlock(session: .dummy, showContents: true, color: .purple, height: 80)
            }
            TimeBlock(session: .dummy, showContents: true, color: .pink, height: 120)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
            Group {
                HStack {
                    TimeBlock(session: .dummy, showContents: true, color: .pink, height: 80)
                    TimeBlock(session: .dummy, showContents: true, color: .blue, height: 80)
                }
                HStack {
                    TimeBlock(session: .dummy, showContents: true, color: .orange, height: 80)
                    TimeBlock(session: .dummy, showContents: true, color: .green, height: 80)
                    TimeBlock(session: .dummy, showContents: true, color: .purple, height: 80)
                }
            }
            .environment(\.colorScheme, .dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .background(Color(.systemBackground))
    }
}
