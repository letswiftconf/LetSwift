//
//  SocialAccount.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

// MARK: - Social Account
/// Social account information.
class SocialAccount: Identifiable, Codable, ObservableObject {
    let id = UUID()
    var category: SocialAccount.Service { willSet { objectWillChange.send() } }
    var url: URL { willSet { objectWillChange.send() } }
    
    // MARK: - Initialization
    init(category: SocialAccount.Service,
         url: URL) {
        self.category = category
        self.url = url
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case id, category, url
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
}

// MARK: - Social Service
extension SocialAccount {
    enum Service: String, Identifiable, Codable, CaseIterable {
        case unspecified
        case email
        case website
        case github
        case linkedin
        case facebook
        case instagram
        case twitter
        
        var id: String {
            return rawValue
        }
        
        var localizedName: String {
            switch self {
            case .unspecified: return "Unspecified"
            case .email: return "Email"
            case .website: return "Website"
            case .github: return "GitHub"
            case .linkedin: return "LinkedIn"
            case .facebook: return "Facebook"
            case .instagram: return "Instagram"
            case .twitter: return "Twitter"
            }
        }
    }
}
