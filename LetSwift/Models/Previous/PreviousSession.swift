//
//  PreviousSession.swift
//  LetSwift
//
//  Created by 문예지 on 10/16/25.
//

import Foundation

struct PreviousSession {
    static let allYearsKey = "전체"
    static let allYearsValue = -1
    private let sessions: [Int] = [2024, 2023, 2022, 2020, 2019, 2018, 2017, 2016]
    
    /// Cache for loaded conference data to avoid re-loading and re-parsing JSON files
    private static var conferenceCache: [String: Conference] = [:]
    private static var allConferencesCache: Conference?

    var years: [String] {
        return [PreviousSession.allYearsKey] + sessions.map { String($0) }
    }

    var latestSession: String {
        return PreviousSession.allYearsKey
    }

    func conference(for year: String) -> Conference {
        if year == PreviousSession.allYearsKey {
            return allConferences()
        }
        
        // Check cache first
        if let cached = PreviousSession.conferenceCache[year] {
            return cached
        }
        
        guard let url = Bundle.main.url(forResource: "playlist-" + year, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let conferenceData = try? JSONDecoder().decode(Conference.self, from: data) else {
            fatalError("Failed to load or parse JSON for year \(year)")
        }
        
        // Store in cache
        PreviousSession.conferenceCache[year] = conferenceData
        return conferenceData
    }
    
    /// Loads and combines all conferences from all available years.
    /// Uses graceful error handling to ensure partial data can be loaded even if some years fail.
    /// This is intentionally different from `conference(for:)` which uses fatalError for missing data.
    private func allConferences() -> Conference {
        // Check cache first
        if let cached = PreviousSession.allConferencesCache {
            return cached
        }
        
        var allItems: [VideoItem] = []
        
        for session in sessions {
            let yearString = String(session)
            
            // Try to use cached individual conference first
            if let cached = PreviousSession.conferenceCache[yearString] {
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
            
            // Cache the individual conference
            PreviousSession.conferenceCache[yearString] = conferenceData
            allItems.append(contentsOf: conferenceData.items)
        }
        
        let allConferencesData = Conference(year: PreviousSession.allYearsValue, items: allItems)
        
        // Cache the aggregated result
        PreviousSession.allConferencesCache = allConferencesData
        
        return allConferencesData
    }
}
