//
//  PreviousSession.swift
//  LetSwift
//
//  Created by 문예지 on 10/16/25.
//

import Foundation

struct PreviousSession {
    static let allYearsKey = "전체"
    private let sessions: [Int] = [2024, 2023, 2022, 2020, 2019, 2018, 2017, 2016]

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
        
        guard let url = Bundle.main.url(forResource: "playlist-" + year, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let conferenceData = try? JSONDecoder().decode(Conference.self, from: data) else {
            fatalError("Failed to load or parse JSON for year \(year)")
        }
        return conferenceData
    }
    
    private func allConferences() -> Conference {
        var allItems: [VideoItem] = []
        
        for session in sessions {
            let yearString = String(session)
            if let url = Bundle.main.url(forResource: "playlist-" + yearString, withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let conferenceData = try? JSONDecoder().decode(Conference.self, from: data) {
                allItems.append(contentsOf: conferenceData.items)
            }
        }
        
        return Conference(year: 0, items: allItems)
    }
}
