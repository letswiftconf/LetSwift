//
//  SocialAccount.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

/// Represents a social account.

struct SocialAccount: Codable, Identifiable {
    enum Category: String, Codable, CaseIterable {
        case email
        case website
        case github
        case linkedin
        case facebook
        case instagram
        case twitter
        case unspecified
    }
    
    let id = UUID()
    let category: SocialAccount.Category
    let url: URL
}
