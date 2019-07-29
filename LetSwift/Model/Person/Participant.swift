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
    enum Role: String, Codable {
        case organizer
        case speaker
        case staff
        case unspecified
    }
    
    let id = UUID()
    let category: Participant.Role
    let profile: Profile
}
