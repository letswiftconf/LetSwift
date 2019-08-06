//
//  Participant.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

/// Represents a person's role in an event.

struct Participant: Codable, Identifiable {
    enum Role: String, Codable, CaseIterable, Identifiable {
        case organizer
        case speaker
        case staff
        case unspecified
        
        var id: String {
            return rawValue
        }
        
        var name: String {
            switch self {
            case .organizer: return "Organizer"
            case .speaker: return "Speaker"
            case .staff: return "Staff"
            case .unspecified: return "Unspecified"
            }
        }
    }
    
    let id = UUID()
    let category: Participant.Role
    let profile: Profile
}
