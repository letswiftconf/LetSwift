//
//  SocialAccount.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

/// Represents a social account.

struct SocialAccount: Codable, Identifiable {
    enum Service: String, Codable, CaseIterable, Identifiable {
        case email
        case website
        case github
        case linkedin
        case facebook
        case instagram
        case twitter
        case unspecified
        
        var id: String {
            return rawValue
        }
        
        var name: String {
            switch self {
            case .email: return "Email"
            case .website: return "Website"
            case .github: return "GitHub"
            case .linkedin: return "LinkedIn"
            case .facebook: return "Facebook"
            case .instagram: return "Instagram"
            case .twitter: return "Twitter"
            case .unspecified: return "Unspecified"
            }
        }
    }
    
    let id = UUID()
    let category: SocialAccount.Service
    let url: URL
}
