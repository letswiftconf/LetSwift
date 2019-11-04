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
                HStack {
                    VStack(alignment: .leading) {
                        Text(session.title)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text(session.speaker)
                            .fontWeight(.bold)
                        Text(session.time)
                            .fontWeight(.bold)
                        if session.level != "" {
                            ZStack {
                                Circle()
                                Text(session.level)
                                    .foregroundColor(color)
                                    .font(.system(size: 10))
                                    .fontWeight(.bold)
                            }
                            .frame(width: 13, height: 13)
                        }
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        //                        Text("🍵")
                        Spacer()
                    }
                }
                .foregroundColor(.white)
                .font(.caption)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
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
