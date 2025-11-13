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
    
    var body: some View {
        ZStack {
            // Blurred background
//            ZStack {
//                Color.gray.opacity(0.1)
//                    .blur(radius: 100)
//                    .ignoresSafeArea()
//                
//                Color.black.opacity(0.1)
//                    .ignoresSafeArea()
//            }
            
            // Scrollable content with separate rounded squares
            ScrollView {
                VStack(spacing: 4) {
                    // Session information - rounded square with glass effect
                    VStack(alignment: .leading, spacing: 4) {
                        // Duration in top right
                        HStack {
                            Spacer()
                            Text(session.durationString)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        
                        // Session title
                        Text(session.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        // Speaker name
                        if !session.speakers.isEmpty {
                            Text(session.speakers.first ?? "")
                                .font(.system(size: 12, weight: .light))
                                .foregroundColor(Color.white)
                        }
                        
                        // Time range
                        Text(session.timeRange)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassContainer(radius: 18)
                    
                    // Close button - separate rounded square
//                    Button(action: {
//                        HapticFeedback.click()
//                        dismiss()
//                    }) {
//                        Text("닫기")
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 42)
//                            .glassContainer(radius: 18)
//                    }
//                    .buttonStyle(.plain)
//                    .padding(.horizontal, 20)
                }
                .padding(.horizontal, 10)
//                .padding(.top, 70)
//                .padding(.bottom, 16)
            }
        }
    }
    
}

// MARK: - Glass Style Extensions
extension View {
    @ViewBuilder
    func glassContainer(radius: CGFloat) -> some View {
        if #available(watchOS 26, *) {
            self
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: radius))
        } else {
            self
                .background(
                    ZStack {
                        // More transparent blur
                        Color.gray.opacity(0.08)
                            .blur(radius: 30)
                        
                        // Glass effect
                        ZStack {
                            Color.white.opacity(0.02)
                            
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.05),
                                    Color.clear,
                                    Color.white.opacity(0.02)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        }
                    }
                )
                .cornerRadius(radius)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
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
        }
    }
}
