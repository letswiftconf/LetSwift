//
//  DeviceRegistrationService.swift
//  LetSwift
//
//  Created by 김인환 on 10/23/25.
//

import Foundation

/// Service for registering device tokens with the push notification server
final class DeviceRegistrationService: Sendable {

    static let shared = DeviceRegistrationService()

    private init() {}

    /// Register device tokens with the server
    /// - Parameter request: Device registration request containing all tokens
    /// - Returns: Registration response on success
    func registerDevice(_ request: DeviceRegistrationRequest) async throws -> DeviceRegistrationResponse {
        guard let url = URL(string: Constants.URL.deviceRegisterURL) else {
            throw DeviceRegistrationError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        urlRequest.httpBody = try encoder.encode(request)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw DeviceRegistrationError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw DeviceRegistrationError.serverError(statusCode: httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let registrationResponse = try decoder.decode(DeviceRegistrationResponse.self, from: data)

        return registrationResponse
    }
}

/// Errors that can occur during device registration
enum DeviceRegistrationError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid server URL"
        case .invalidResponse:
            return "Invalid server response"
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        }
    }
}
