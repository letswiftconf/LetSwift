//
//  DeviceRegistration.swift
//  LetSwift
//
//  Created by 김인환 on 10/23/25.
//

import Foundation

/// Request model for device token registration
struct DeviceRegistrationRequest: Codable {
    let deviceId: String
    let fcmToken: String
    let pushToStartToken: String?
    let liveActivityTokens: [String: String]?  // track -> token mapping
    let appVersion: String?
    let platform: String

    enum CodingKeys: String, CodingKey {
        case deviceId
        case fcmToken
        case pushToStartToken
        case liveActivityTokens
        case appVersion
        case platform
    }
}

/// Response model for device token registration
struct DeviceRegistrationResponse: Codable {
    let success: Bool
    let message: String
    let registeredAt: String
}
