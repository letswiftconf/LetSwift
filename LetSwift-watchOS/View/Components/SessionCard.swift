//
//  SessionCard.swift
//  LetSwift-watchOS Watch App
//
//  Created by Coby on 11/25/24.
//

import SwiftUI
import Accessibility

struct SessionCard: View {
    let session: SessionItem
    let onTap: () -> Void
    let viewModel: WatchSessionViewModel
    let isLast: Bool
    
    private var isFavorite: Bool {
        let _ = viewModel.updateTrigger // Force observation
        return viewModel.isFavorite(session.id)
    }

    /// What VoiceOver speaks for the card, in the order it is drawn: "10:00 AM, <title>, 40 minutes".
    /// The end time is left out; it is the start plus the length, and the list has many rows.
    private var spokenSummary: String {
        [session.spokenStartTime, session.name, session.spokenDuration].joined(separator: ", ")
    }

    private func toggleFavorite() {
        HapticFeedback.click()
        viewModel.toggleFavorite(session.id)
        // Confirms the change for VoiceOver, where the heart is not an element of its own.
        let message: LocalizedStringResource = isFavorite ? "session.favorite.added" : "session.favorite.removed"
        AccessibilityNotification.Announcement(String(localized: message)).post()
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
                    toggleFavorite()
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
        // VoiceOver: the card is one element. Activating it opens the details, and the heart
        // becomes an action (swipe up or down) instead of an unlabeled button inside a button.
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(spokenSummary)
        .accessibilityValue(isFavorite ? Text("session.favorite") : Text(verbatim: ""))
        .accessibilityAddTraits(.isButton)
        .accessibilityAction { onTap() }
        .accessibilityAction(named: isFavorite ? Text("session.favorite.remove") : Text("session.favorite.add")) {
            toggleFavorite()
        }
    }
}

