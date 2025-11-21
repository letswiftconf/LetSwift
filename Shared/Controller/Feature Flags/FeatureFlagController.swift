//
//  FeatureFlagController.swift
//  LetSwift
//
//  Created by BumMo Koo on 11/21/25.
//

import Foundation

@Observable
@MainActor
class FeatureFlagController {
    static let shared = FeatureFlagController()

    private(set) var featureFlags: FeatureFlagsResponse?
    private(set) var lastUpdated: Date?
    private(set) var isLoading = false

    private let userDefaultsKey = "app.letswift.featureFlags"
    private let lastUpdatedKey = "app.letswift.featureFlags.lastUpdated"

    private var currentAppVersion: String {
        Bundle.appShortVersion
    }

    // MARK: - Feature Flag Properties
    var commemorativePass2025: Bool {
        isFeatureEnabled("commemorative_pass_2025", currentAppVersion: currentAppVersion)
    }

    var enableSurvey2025: Bool {
        isFeatureEnabled("enable_survey_2025", currentAppVersion: currentAppVersion)
    }

    private init() {
        loadFromCache()
    }

    // MARK: - Fetch
    func fetchFeatureFlags() async throws {
        isLoading = true
        defer { isLoading = false }

        let (data, _) = try await URLSession.shared.data(from: .featureFlags)
        let response = try JSONDecoder().decode(FeatureFlagsResponse.self, from: data)

        featureFlags = response
        lastUpdated = Date()
        saveToCache()
    }

    // MARK: - Cache
    private func saveToCache() {
        guard let featureFlags else { return }

        do {
            let data = try JSONEncoder().encode(featureFlags)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
            UserDefaults.standard.set(lastUpdated, forKey: lastUpdatedKey)
        } catch {
            print("Failed to save feature flags to cache: \(error)")
        }
    }

    private func loadFromCache() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return
        }

        do {
            let cached = try JSONDecoder().decode(FeatureFlagsResponse.self, from: data)
            featureFlags = cached
            lastUpdated = UserDefaults.standard.object(forKey: lastUpdatedKey) as? Date
        } catch {
            print("Failed to load feature flags from cache: \(error)")
        }
    }

    // MARK: - Check
    func isFeatureEnabled(_ key: String, currentAppVersion: String) -> Bool {
        guard let flag = featureFlags?.featureFlags[key] else {
            return false
        }

        guard flag.enabled else {
            return false
        }

        // Check minimum version requirement
        if let minVersion = flag.minAppVersion {
            return isVersion(currentAppVersion, greaterThanOrEqualTo: minVersion)
        }

        return true
    }

    // MARK: - Version Comparison
    private func isVersion(_ version: String, greaterThanOrEqualTo minVersion: String) -> Bool {
        // Returns true if version >= minVersion
        return version.compare(minVersion, options: .numeric) != .orderedAscending
    }
}
