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
        Task {
            do {
                try await fetchFeatureFlags()
            } catch {
                print("[FeatureFlags] ❌ Failed to fetch on init: \(error)")
            }
        }
    }

    // MARK: - Fetch
    func fetchFeatureFlags() async throws {
        print("[FeatureFlags] Fetching feature flags from network...")
        isLoading = true
        defer { isLoading = false }

        let (data, _) = try await URLSession.shared.data(from: .featureFlags)
        let response = try JSONDecoder().decode(FeatureFlagsResponse.self, from: data)

        featureFlags = response
        lastUpdated = Date()
        print("[FeatureFlags] Successfully fetched \(response.featureFlags.count) flags")
        saveToCache()
    }

    // MARK: - Cache
    private func saveToCache() {
        guard let featureFlags else { return }

        do {
            let data = try JSONEncoder().encode(featureFlags)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
            UserDefaults.standard.set(lastUpdated, forKey: lastUpdatedKey)
            print("[FeatureFlags] Saved \(featureFlags.featureFlags.count) flags to cache")
        } catch {
            print("[FeatureFlags] ❌ Failed to save to cache: \(error)")
        }
    }

    private func loadFromCache() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            print("[FeatureFlags] No cached flags found")
            return
        }

        do {
            let cached = try JSONDecoder().decode(FeatureFlagsResponse.self, from: data)
            featureFlags = cached
            lastUpdated = UserDefaults.standard.object(forKey: lastUpdatedKey) as? Date
            let timeInfo = lastUpdated.map { "updated \(formatTimeAgo($0))" } ?? "unknown age"
            print("[FeatureFlags] Loaded \(cached.featureFlags.count) flags from cache (\(timeInfo))")
        } catch {
            print("[FeatureFlags] ❌ Failed to load from cache: \(error)")
        }
    }

    private func formatTimeAgo(_ date: Date) -> String {
        let seconds = Date().timeIntervalSince(date)
        if seconds < 60 {
            return "\(Int(seconds))s ago"
        } else if seconds < 3600 {
            return "\(Int(seconds / 60))m ago"
        } else if seconds < 86400 {
            return "\(Int(seconds / 3600))h ago"
        } else {
            return "\(Int(seconds / 86400))d ago"
        }
    }

    // MARK: - Check
    func isFeatureEnabled(_ key: String, currentAppVersion: String) -> Bool {
        guard let flag = featureFlags?.featureFlags[key] else {
            print("[FeatureFlags] Flag '\(key)' not found")
            return false
        }

        guard flag.enabled else {
            print("[FeatureFlags] Flag '\(key)' is disabled")
            return false
        }

        // Check minimum version requirement
        if let minVersion = flag.minAppVersion {
            let meetsVersion = isVersion(currentAppVersion, greaterThanOrEqualTo: minVersion)
            print("[FeatureFlags] Flag '\(key)': enabled=true, version check: \(currentAppVersion) >= \(minVersion) = \(meetsVersion)")
            return meetsVersion
        }

        print("[FeatureFlags] Flag '\(key)' is enabled (no version requirement)")
        return true
    }

    // MARK: - Version Comparison
    private func isVersion(_ version: String, greaterThanOrEqualTo minVersion: String) -> Bool {
        // Returns true if version >= minVersion
        return version.compare(minVersion, options: .numeric) != .orderedAscending
    }
}
