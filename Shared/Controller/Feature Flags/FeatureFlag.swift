//
//  FeatureFlag.swift
//  LetSwift
//
//  Created by BumMo Koo on 11/21/25.
//

import Foundation

struct FeatureFlag: Codable {
    let enabled: Bool
    let minAppVersion: String?
    
    enum CodingKeys: String, CodingKey {
        case enabled
        case minAppVersion = "min_app_version"
    }
}
