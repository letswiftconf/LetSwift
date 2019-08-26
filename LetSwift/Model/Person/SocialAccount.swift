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
    
    // MARK: - Functions
    func urlString(path: String) -> String {
        if let domain = category.domain {
            return "\(category.urlScheme)\(domain)/\(path)"
        } else {
            return "\(category.urlScheme)\(path)"
        }
    }
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
        
        var domain: String? {
            switch self {
            case .github: return "www.github.com"
            case .linkedin: return "www.linkedin.com"
            case .facebook: return "www.facebook.com"
            case .instagram: return "www.instagram.com"
            case .twitter: return "www.twitter.com"
            default: return nil
            }
        }
        
        var urlScheme: String {
            switch self {
            case .email:
                return "mailto:"
            case .github, .linkedin, .facebook, .instagram, .twitter:
                return "https://"
            case .website, .unspecified:
                return ""
            }
        }
    }
}

// MARK: - Dummy
extension SocialAccount {
    static var dummy: SocialAccount {
        return SocialAccount(category: .email,
                             url: URL(string: "mailto:ksquareatm@gmail.com")!)
    }
}
