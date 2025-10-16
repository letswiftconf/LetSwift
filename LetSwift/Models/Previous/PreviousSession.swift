//
//  PreviousSession.swift
//  LetSwift
//
//  Created by 문예지 on 10/16/25.
//

import Foundation

struct PreviousSession {
    private let sessions: [Int] = [2024, 2023, 2022, 2020, 2019, 2018, 2017, 2016]

    var years: [String] {
        return sessions.map { String($0) }
    }

    var latestSession: String {
        guard let latest = sessions.first else {
            return "2024"
        }
        return String(latest)
    }

    func conference(for year: String) -> Conference {
        guard let url = Bundle.main.url(forResource: "playlist-" + year, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let conferenceData = try? JSONDecoder().decode(Conference.self, from: data) else {
            fatalError("Failed to load or parse JSON for year \(year)")
        }
        return conferenceData
    }
}
