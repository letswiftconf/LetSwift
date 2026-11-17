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
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    /// The favorite button grows with its symbol.
    @ScaledMetric(relativeTo: .body) private var favoriteSize: CGFloat = 20

    private var isFavorite: Bool {
        let _ = viewModel.updateTrigger // Force observation
        return viewModel.isFavorite(session.id)
    }
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            Group {
                if dynamicTypeSize > .large {
                    // Larger text gets the full width of the card: the favorite button moves down beside the duration.
                    VStack(alignment: .leading, spacing: 4) {
                        timeRange
                        title
                        HStack(spacing: 8) {
                            duration
                            Spacer(minLength: 0)
                            favoriteButton
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    HStack(spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            timeRange
                                .fixedSize()
                            title
                            duration
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        favoriteButton
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(hex: "3F3F3F"))
            .cornerRadius(8.5)
        }
        .buttonStyle(.plain)
    }
    
    private var timeRange: some View {
        Text(session.timeRange)
            .font(.body.weight(.bold))
            .foregroundColor(.white)
    }
    
    private var title: some View {
        Text(session.name)
            .font(.body.weight(.medium))
            .foregroundColor(.white)
//            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var duration: some View {
        Text(session.durationString)
            .font(.body.weight(.light))
            .foregroundColor(.white)
    }
    
    /// Favorite button (separate tap target)
    private var favoriteButton: some View {
        Button(action: {
            HapticFeedback.click()
            viewModel.toggleFavorite(session.id)
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.body.weight(.medium))
                .foregroundColor(isFavorite ? Color(hex: "F14D35") : .white)
                .frame(width: favoriteSize, height: favoriteSize)
        }
        .buttonStyle(.plain)
    }
}
