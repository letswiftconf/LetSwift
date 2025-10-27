//
//  SessionCard.swift
//  LetSwift-watchOS Watch App
//
//  Created by Coby on 11/25/24.
//

import SwiftUI

struct SessionCard: View {
    let session: SessionItem
    let onTap: () -> Void
    @State private var isFavorite = false
    let isLast: Bool
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    // Time range
                    Text(session.timeRange)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.white)
                        .fixedSize()
                    
                    // Session title
                    Text(session.name)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    // Duration
                    Text(session.durationString)
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                // Favorite button (separate tap target)
                Button(action: {
                    HapticFeedback.click()
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(isFavorite ? .red : .white)
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(hex: "6C6C6C"))
            .cornerRadius(8.5)
        }
        .buttonStyle(.plain)
    }
}

