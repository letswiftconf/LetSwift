//
//  WatchSessionViewModel.swift
//  LetSwift-watchOS Watch App
//
//  Created by Coby on 11/25/24.
//

import Foundation
import WatchKit

@MainActor
@Observable
final class WatchSessionViewModel {
    var sessions: [SessionItem] = []
    var currentTrack: WatchTrack = .trackA
    
    private var allSessions: [SessionItem] = []
    private var favoriteIds: Set<String> = []
    
    var filteredSessions: [SessionItem] {
        sessions.filter { $0.displayTrack == currentTrack.displayName }
    }
    
    init() {
        loadFavoriteIds()
        loadSessions()
    }
    
    private func loadFavoriteIds() {
        if let data = UserDefaults.standard.data(forKey: "favoriteSessionIds"),
           let ids = try? JSONDecoder().decode(Set<String>.self, from: data) {
            favoriteIds = ids
        }
    }
    
    private func saveFavoriteIds() {
        if let data = try? JSONEncoder().encode(favoriteIds) {
            UserDefaults.standard.set(data, forKey: "favoriteSessionIds")
        }
    }
    
    func isFavorite(_ sessionId: String) -> Bool {
        favoriteIds.contains(sessionId)
    }
    
    func toggleFavorite(_ sessionId: String) {
        if favoriteIds.contains(sessionId) {
            favoriteIds.remove(sessionId)
        } else {
            favoriteIds.insert(sessionId)
        }
        saveFavoriteIds()
    }
    
    func loadSessions() {
        // Load from Schedule.json
        guard let url = Bundle.main.url(forResource: "Schedule", withExtension: "json") else {
            print("❌ Failed to find Schedule.json")
            print("Bundle paths: \(Bundle.main.paths(forResourcesOfType: "json", inDirectory: nil))")
            return
        }
        
        print("✅ Found Schedule.json at: \(url)")
        
        guard let data = try? Data(contentsOf: url) else {
            print("❌ Failed to load Schedule.json data")
            return
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            print("❌ Failed to parse Schedule.json as JSON array")
            return
        }
        
        print("✅ Loaded Schedule.json with \(json.count) items")
        
        var loadedSessions: [SessionItem] = []
        
        for item in json {
            guard let id = item["id"] as? String,
                  let name = item["name"] as? String,
                  let type = item["type"] as? String,
                  let trackRaw = item["track"] as? String,
                  let startTimeStr = item["start_time"] as? String,
                  let endTimeStr = item["end_time"] as? String,
                  let duration = item["duration"] as? Int else {
                continue
            }
            
            // Parse dates
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            guard let startTime = dateFormatter.date(from: startTimeStr),
                  let endTime = dateFormatter.date(from: endTimeStr) else {
                continue
            }
            
            // Parse speakers
            var speakers: [String] = []
            if let speakersArray = item["speakers"] as? [[String: Any]] {
                speakers = speakersArray.compactMap { $0["name"] as? String }
            }
            
            let session = SessionItem(
                id: id,
                name: name,
                type: SessionType(rawValue: type) ?? .presentation,
                track: trackRaw,
                startTime: startTime,
                endTime: endTime,
                duration: duration,
                speakers: speakers
            )
            
            loadedSessions.append(session)
        }
        
        print("✅ Parsed \(loadedSessions.count) sessions")
        
        self.allSessions = loadedSessions
        self.sessions = loadedSessions.filter { $0.isSession } // Filter to only presentation sessions
        
        print("✅ Filtered to \(self.sessions.count) presentation sessions")
        print("✅ Track A sessions: \(self.sessions.filter { $0.displayTrack == "A" }.count)")
        print("✅ Track B sessions: \(self.sessions.filter { $0.displayTrack == "B" }.count)")
    }
    
    func toggleTrack() {
        currentTrack = currentTrack == .trackA ? .trackB : .trackA
    }
}

struct SessionItem: Identifiable, Codable {
    let id: String
    let name: String
    let type: SessionType
    let track: String
    let startTime: Date
    let endTime: Date
    let duration: Int
    let speakers: [String]
    
    var isSession: Bool {
        type == .presentation
    }
    
    var displayTrack: String {
        if track.contains("트랙 A") || track.contains("Track A") {
            return "A"
        } else if track.contains("트랙 B") || track.contains("Track B") {
            return "B"
        }
        return ""
    }
    
    var timeRange: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return "\(formatter.string(from: startTime)) ~ \(formatter.string(from: endTime))"
    }
    
    var durationString: String {
        return "\(duration / 60)분"
    }
    
    var speakerName: String {
        speakers.first ?? ""
    }
}

enum SessionType: String, Codable {
    case presentation
    case recess
    case lunch
    case opening
    case closing
    case entry
}

enum WatchTrack {
    case trackA
    case trackB
    
    var displayName: String {
        switch self {
        case .trackA: return "A"
        case .trackB: return "B"
        }
    }
    
    var buttonText: String {
        switch self {
        case .trackA: return "B"
        case .trackB: return "A"
        }
    }
}

