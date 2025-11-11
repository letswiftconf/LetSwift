//
//  TabItem.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
//

import Foundation
import SwiftUI

enum TabItem: CaseIterable {
    case home
    case session
    case previous
    case more
    case search
    
    var icon: String {
        switch self {
        case .home:
            "house"
        case .session:
            "music.microphone"
        case .previous:
            "tray.full"
        case .more:
            "ellipsis"
        case .search:
            "magnifyingglass"
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
        case .search:
            "search.title"
        }
    }
    
    static var tabCases: [TabItem] {
        [.home, .session, .previous, .search, .more]
    }
}
