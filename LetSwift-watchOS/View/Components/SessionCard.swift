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
            // The favorite button stays beside the text while the time fits on one line there.
            // Once it doesn't (larger text, smaller watches), the text gets the full width of the card.
            ViewThatFits(in: .horizontal) {
                sideBySide
                stacked
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(hex: "3F3F3F"))
            .cornerRadius(8.5)
        }
        .buttonStyle(.plain)
    }
    
    private var sideBySide: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                timeRange
                    .fixedSize()
                title
                duration
            }
            // With an ideal width of zero, the time is the widest thing `ViewThatFits` measures here.
            .frame(idealWidth: 0, maxWidth: .infinity, alignment: .leading)

            // No minimum length, so the button stays here for as long as the time fits beside it.
            Spacer(minLength: 0)

            favoriteButton
        }
    }
    
    /// The favorite button moves down beside the duration.
    private var stacked: some View {
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
    }
    
    private var timeRange: some View {
        Text(session.timeRange)
            .font(.body.weight(.bold))
            // Every time is as wide as the next, so every card of the timetable gets the same layout.
            .monospacedDigit()
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
