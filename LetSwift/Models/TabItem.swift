//
//  TabItem.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
//

import Foundation
import SwiftUI

enum TabItem: CaseIterable {
    case website
    case home
    case previous
    case more
    case search
    
    var icon: String {
        switch self {
        case .website:
            "globe"
        case .home:
            "house"
        case .previous:
            "play.rectangle.on.rectangle"
        case .more:
            "ellipsis"
        case .search:
            "magnifyingglass"
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .website:
            "website.title"
        case .home:
            "home.title"
        case .previous:
            "video.title"
        case .more:
            "more.title"
        case .search:
            "search.title"
        }
    }
    
    static var tabCases: [TabItem] {
        [.website, .home, .previous, .more]
    }
}
