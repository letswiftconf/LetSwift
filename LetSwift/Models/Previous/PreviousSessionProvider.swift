//
//  PreviousSessionProvider.swift
//  LetSwift
//
//  Created by 문예지 on 10/16/25.
//

import Foundation

struct PreviousSessionProvider {
    static let allYearsKey = "전체"
    static let allYearsValue = -1
    private let sessions: [Int] = [2024, 2023, 2022, 2020, 2019, 2018, 2017, 2016]

    private let cacheManager = PreviousSessionCacheManager.shared

    var years: [String] {
        return [PreviousSessionProvider.allYearsKey] + sessions.map { String($0) }
    }

    var latestSession: String {
        return PreviousSessionProvider.allYearsKey
    }

    func getConference(for year: String) async -> Conference {
        if year == PreviousSessionProvider.allYearsKey {
            return await allConferences()
        }

        // Check cache first via actor
        if let cached = await cacheManager.conference(forYear: year) {
            return cached
        }

        guard let url = Bundle.main.url(forResource: "playlist-" + year, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let conferenceData = try? JSONDecoder().decode(Conference.self, from: data) else {
            fatalError("Failed to load or parse JSON for year \(year)")
        }

        // Store in cache via actor
        await cacheManager.updateConferenceCache(year: year, conference: conferenceData)
        return conferenceData
    }

    /// Loads and combines all conferences from all available years.
    /// Uses graceful error handling to ensure partial data can be loaded even if some years fail.
    /// This is intentionally different from `conference(for:)` which uses fatalError for missing data.
    private func allConferences() async -> Conference {
        // Check aggregated cache first via actor
        if let cached = await cacheManager.allConferences() {
            return cached
        }

        var allItems: [VideoItem] = []

        for session in sessions {
            let yearString = String(session)

            // Try to use cached individual conference first via actor
            if let cached = await cacheManager.conference(forYear: yearString) {
                allItems.append(contentsOf: cached.items)
                continue
            }

            guard let url = Bundle.main.url(forResource: "playlist-" + yearString, withExtension: "json") else {
                print("Warning: Could not find playlist file for year \(yearString)")
                continue
            }

            guard let data = try? Data(contentsOf: url) else {
                print("Warning: Could not load data from playlist file for year \(yearString)")
                continue
            }

            guard let conferenceData = try? JSONDecoder().decode(Conference.self, from: data) else {
                print("Warning: Could not decode playlist data for year \(yearString)")
                continue
            }

            // Cache the individual conference via actor
            await cacheManager.updateConferenceCache(year: yearString, conference: conferenceData)
            allItems.append(contentsOf: conferenceData.items)
        }

        let allConferencesData = Conference(year: PreviousSessionProvider.allYearsValue, items: allItems)

        // Cache the aggregated result via actor
        await cacheManager.updateAllConferencesCache(allConferencesData)

        return allConferencesData
    }
}
