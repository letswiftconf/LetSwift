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
    let viewModel: WatchSessionViewModel
    let isLast: Bool
    
    private var isFavorite: Bool {
        let _ = viewModel.updateTrigger // Force observation
        return viewModel.isFavorite(session.id)
    }
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    // Time range
                    Text(session.timeRange)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .fixedSize()
                    
                    // Session title
                    Text(session.name)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
//                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    // Duration
                    Text(session.durationString)
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                // Favorite button (separate tap target)
                Button(action: {
                    HapticFeedback.click()
                    viewModel.toggleFavorite(session.id)
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(isFavorite ? Color(hex: "F14D35") : .white)
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(hex: "3F3F3F"))
            .cornerRadius(8.5)
        }
        .buttonStyle(.plain)
    }
}

