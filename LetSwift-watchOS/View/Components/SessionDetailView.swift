//
//  SessionDetailView.swift
//  LetSwift-watchOS Watch App
//
//  Created by Coby on 11/25/24.
//

import SwiftUI

struct SessionDetailView: View {
    let session: SessionItem
    let dismiss: () -> Void
    @State private var lightRotation = Angle(degrees: 0)
    
    var body: some View {
        ZStack {
            // Blurred background (excluding navigation bar area)
            VStack(spacing: 0) {
                Color.clear.frame(height: 40) // Reserve space for navigation bar
                Color.black.opacity(0.6)
            }
            .onTapGesture {
                dismiss()
            }
            
            // Scrollable content with separate rounded squares
            ScrollView {
                VStack(spacing: 12) {
                    // Session information - rounded square with glass effect
                    VStack(alignment: .leading, spacing: 10) {
                        // Duration in top right
                        HStack {
                            Spacer()
                            Text(session.durationString)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        
                        // Session title
                        Text(session.name)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        // Speaker name
                        if !session.speakers.isEmpty {
                            Text(session.speakers.first ?? "")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        
                        // Time range
                        Text(session.timeRange)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        ZStack {
                            Color.white.opacity(0.08)
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.15),
                                    Color.clear,
                                    Color.white.opacity(0.08)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        }
                    )
                    .cornerRadius(18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.6),
                                        Color.white.opacity(0.2)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                    )
                    .rotation3DEffect(
                        lightRotation,
                        axis: (x: 0.5, y: 0.5, z: 0),
                        perspective: 0.8
                    )
                    
                    // Close button - separate rounded square
                    Button(action: {
                        HapticFeedback.click()
                        dismiss()
                    }) {
                        Text("닫기")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 42)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(18)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 12)
                .padding(.top, 52)
                .padding(.bottom, 16)
            }
        }
        .onAppear {
            // 지속적인 빛 반사 움직임 (리퀴드 느낌)
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                lightRotation = Angle(degrees: 8)
            }
        }
    }
}
