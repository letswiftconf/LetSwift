//
//  SessionTab.swift
//  LetSwift
//
//  Created by Haeseok Lee on 9/3/24.
//

import Foundation

enum SessionTab: String, Identifiable, CaseIterable {
    var id: String { self.rawValue }
    case star, ember, savedSession

    var title: String {
        switch self {
        case .star: return "EMBER"
        case .ember: return "STAR"
        case .savedSession: return NSLocalizedString("timetable.tab.savedSession", comment: "Saved Session tab title")
        }
    }
}
