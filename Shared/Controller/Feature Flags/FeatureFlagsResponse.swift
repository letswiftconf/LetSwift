//
//  FeatureFlagsResponse.swift
//  LetSwift
//
//  Created by BumMo Koo on 11/21/25.
//

import Foundation

struct FeatureFlagsResponse: Codable {
    let featureFlags: [String: FeatureFlag]
    let updated: String
    
    enum CodingKeys: String, CodingKey {
        case featureFlags = "feature_flags"
        case updated
    }
}
