//
//  SessionTab.swift
//  LetSwift
//
//  Created by Haeseok Lee on 9/3/24.
//

import Foundation

enum SessionTab: String, Identifiable, CaseIterable {
    var id: String { self.rawValue }
    case trackA, trackB, savedSession

    var title: String {
        switch self {
        case .trackA: return "Track A"
        case .trackB: return "Track B"
        case .savedSession: return NSLocalizedString("timetable.tab.savedSession", comment: "Saved Session tab title")
        }
    }
}
