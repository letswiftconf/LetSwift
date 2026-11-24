//
//  VoiceOverAnnouncement.swift
//  LetSwift-watchOS Watch App
//

import Accessibility
import Foundation

/// Spoken confirmations for changes that are otherwise only visible.
enum VoiceOver {
    /// Speaks `message` once VoiceOver has finished what it is saying, so neither cuts the other off.
    /// Does nothing when VoiceOver is off.
    static func announce(_ message: String) {
        var announcement = AttributedString(message)
        announcement.accessibilitySpeechAnnouncementPriority = .low
        AccessibilityNotification.Announcement(announcement).post()
    }
}
