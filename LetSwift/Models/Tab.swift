//
//  Tab.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
//

import Foundation
import SwiftUI

enum Tab: CaseIterable {
    case home
    case session
    case previous
    case more
    
    var icon: String {
        switch self {
        case .home:
            "house"
        case .session:
            "music.microphone"
        case .previous:
            "play.circle.fill"
        case .more:
            "ellipsis"
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .home:
            "home.title"
        case .session:
            "timetable.title"
        case .previous:
            "previous.title"
        case .more:
            "more.title"
        }
    }
}
