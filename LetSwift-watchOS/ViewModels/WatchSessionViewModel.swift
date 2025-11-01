//
//  WatchSessionViewModel.swift
//  LetSwift-watchOS Watch App
//
//  Created by Coby on 11/25/24.
//

import Foundation
import WatchKit

// API Response Models
struct Session: Identifiable, Codable {
    let id: Int
    let title: String
    let track: String
    let speakers: [Speaker]
    let startTime: Date
    let endTime: Date
    
    struct Speaker: Identifiable, Codable {
        var id: String { self.name }
        let name: String
        let profileImage: String
    }
}

@MainActor
@Observable
final class WatchSessionViewModel {
    var sessions: [SessionItem] = []
    var currentTrack: WatchTrack = .trackA
    var isLoading: Bool = false
    
    @ObservationIgnored
    private var allSessions: [SessionItem] = []
    
    @ObservationIgnored
    private var favoriteIds: Set<String> = []
    
    // This property is used to trigger UI updates when favorites change
    var updateTrigger: Int = 0
    
    var filteredSessions: [SessionItem] {
        sessions.filter { $0.displayTrack == currentTrack.displayName }
    }
    
    @ObservationIgnored
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(serverTimeFormatter)
        return decoder
    }()
    
    @ObservationIgnored
    private let serverTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    @ObservationIgnored
    private var hasLoadedOnce = false
    
    init() {
        loadFavoriteIds()
    }
    
    func loadSessionsOnce() async {
        guard !hasLoadedOnce else { return }
        hasLoadedOnce = true
        loadSessions()
    }
    
    private func loadFavoriteIds() {
        if let data = UserDefaults.standard.data(forKey: "favoriteSessionIds"),
           let ids = try? JSONDecoder().decode(Set<String>.self, from: data) {
            favoriteIds = ids
            print("✅ Loaded \(ids.count) favorites from UserDefaults")
        }
    }
    
    private func saveFavoriteIds() {
        do {
            let data = try JSONEncoder().encode(favoriteIds)
            UserDefaults.standard.set(data, forKey: "favoriteSessionIds")
            print("✅ Saved \(favoriteIds.count) favorites to UserDefaults")
        } catch {
            print("❌ Failed to save favorites: \(error.localizedDescription)")
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
        // Trigger UI update
        updateTrigger += 1
    }
    
    func loadSessions() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            let result = await fetchSessions()
            switch result {
            case .success(let fetchedSessions):
                self.allSessions = fetchedSessions
                self.sessions = fetchedSessions
                // Cache the sessions
                cacheSessions(fetchedSessions)
                print("✅ Loaded \(fetchedSessions.count) sessions from API")
            case .failure(let error):
                print("❌ Failed to fetch sessions: \(error.localizedDescription)")
                // Load from cache as fallback
                loadCachedSessions()
            }
            isLoading = false
        }
    }
    
    private func fetchSessions() async -> Result<[SessionItem], Error> {
        guard let url = URL(string: "http://223.130.133.110:8080/presentations") else {
            return .failure(URLError(.badURL))
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse,
               (200...299) ~= httpResponse.statusCode {
                let sessions = try jsonDecoder.decode([Session].self, from: data)
                let sessionItems = sessions.map { SessionItem(from: $0) }
                return .success(sessionItems)
            } else {
                return .failure(NSError())
            }
        } catch {
            return .failure(error)
        }
    }
    
    private func cacheSessions(_ sessions: [SessionItem]) {
        if let data = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(data, forKey: "cachedSessions")
        }
    }
    
    private func loadCachedSessions() {
        if let data = UserDefaults.standard.data(forKey: "cachedSessions"),
           let sessions = try? JSONDecoder().decode([SessionItem].self, from: data) {
            self.allSessions = sessions
            self.sessions = sessions
            print("✅ Loaded \(sessions.count) sessions from cache")
        } else {
            print("❌ No cached sessions available")
        }
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
    
    init(id: String, name: String, type: SessionType, track: String, startTime: Date, endTime: Date, duration: Int, speakers: [String]) {
        self.id = id
        self.name = name
        self.type = type
        self.track = track
        self.startTime = startTime
        self.endTime = endTime
        self.duration = duration
        self.speakers = speakers
    }
    
    init(from session: Session) {
        self.id = "\(session.id)"
        self.name = session.title
        self.type = .presentation
        self.track = session.track
        self.startTime = session.startTime
        self.endTime = session.endTime
        self.duration = Int(session.endTime.timeIntervalSince(session.startTime))
        self.speakers = session.speakers.map { $0.name }
    }
    
    var isSession: Bool {
        type == .presentation
    }
    
    var displayTrack: String {
        if track.contains("트랙 A") || track.contains("Track A") || track == "A" {
            return "A"
        } else if track.contains("트랙 B") || track.contains("Track B") || track == "B" {
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
        case .trackA: return "STAR(B홀)"
        case .trackB: return "BLAZE(C홀)"
        }
    }
    
    var buttonText: String {
        switch self {
        case .trackA: return "B"
        case .trackB: return "A"
        }
    }
}

