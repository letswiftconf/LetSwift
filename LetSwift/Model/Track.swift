//
//  Track.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

struct Track: Codable, Identifiable {
    enum Category: String, Codable, CaseIterable, Identifiable {
        case session
        case workshop
        
        var id: String {
            return rawValue
        }
        
        var name: String {
            switch self {
            case .session: return "Session"
            case .workshop: return "Workshop"
            }
        }
    }
    
    let id = UUID()
    let category: Track.Category
}
