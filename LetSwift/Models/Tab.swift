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
    case events
    case more
    
    var icon: String {
        switch self {
        case .home:
            "ic_home"
        case .session:
            "ic_timetable"
        case .previous:
            "ic_past"
        case .events:
            "ic_event"
        case .more:
            "ic_menu"
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
        case .events:
            "events.title"
        case .more:
            "more.title"
        }
    }
}
