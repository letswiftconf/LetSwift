//
//  WatchSessionViewModel.swift
//  LetSwift-watchOS Watch App
//
//  Created by Coby on 11/25/24.
//

import Foundation
import WatchKit

// API Response Models (Decodable only - converted to SessionItem for caching)
struct Session: Identifiable, Decodable {
    let id: Int
    let title: String
    let type: String
    let track: String
    let speakers: [Speaker]
    let startTime: Date
    let endTime: Date

    struct Speaker: Identifiable, Decodable {
        var id: String { self.name }
        let name: String
        let profileImage: String

        enum CodingKeys: String, CodingKey {
            case name
            case imageUrl = "image_url"
            case profileImage
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            if let imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) {
                self.profileImage = imageUrl
            } else {
                self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, name, type, track, speakers
        case startTime = "start_time"
        case endTime = "end_time"
    }

    // Legacy keys for cached data
    enum LegacyCodingKeys: String, CodingKey {
        case id, title, track, speakers, startTime, endTime
    }

    init(from decoder: Decoder) throws {
        // Try new format first
        if let container = try? decoder.container(keyedBy: CodingKeys.self),
           container.contains(.name) {
            let idString = try container.decode(String.self, forKey: .id)
            self.id = Int(idString) ?? 0
            self.title = try container.decode(String.self, forKey: .name)
            self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? "presentation"
            let fullTrack = try container.decode(String.self, forKey: .track)
            self.track = fullTrack
                .replacingOccurrences(of: "Track ", with: "")
                .replacingOccurrences(of: "트랙 ", with: "")
            self.speakers = try container.decode([Speaker].self, forKey: .speakers)
            self.startTime = try container.decode(Date.self, forKey: .startTime)
            self.endTime = try container.decode(Date.self, forKey: .endTime)
        } else {
            // Legacy format
            let container = try decoder.container(keyedBy: LegacyCodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.title = try container.decode(String.self, forKey: .title)
            self.type = "presentation"
            self.track = try container.decode(String.self, forKey: .track)
            self.speakers = try container.decode([Speaker].self, forKey: .speakers)
            self.startTime = try container.decode(Date.self, forKey: .startTime)
            self.endTime = try container.decode(Date.self, forKey: .endTime)
        }
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
        let trackLetter = currentTrack == .trackA ? "A" : "B"
        return sessions.filter { $0.displayTrack == trackLetter }
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
        // WatchConnectivity 초기화 및 동기화
        _ = WatchConnectivityManager.shared
        
        // iOS 앱에서 즐겨찾기 업데이트를 받을 수 있도록 NotificationCenter 구독
        NotificationCenter.default.addObserver(
            forName: .favoriteIdsDidUpdate,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor [self] in
                self.loadFavoriteIds()
                self.updateTrigger += 1
            }
        }
    }
    
    func loadSessionsOnce() async {
        guard !hasLoadedOnce else { return }
        hasLoadedOnce = true
        loadSessions()
    }
    
    private func loadFavoriteIds() {
        // iOS 앱과 동일한 키 사용
        if let data = UserDefaults.standard.data(forKey: "savedSessions"),
           let ids = try? JSONDecoder().decode(Set<String>.self, from: data) {
            favoriteIds = ids
            print("✅ Loaded \(ids.count) favorites from UserDefaults")
        }
    }
    
    private func saveFavoriteIds() {
        do {
            let data = try JSONEncoder().encode(favoriteIds)
            // iOS 앱과 동일한 키 사용
            UserDefaults.standard.set(data, forKey: "savedSessions")
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
        
        // WatchConnectivity를 통해 iOS 앱에 즐겨찾기 변경 사항 전송
        Task { @MainActor in
            WatchConnectivityManager.shared.updateApplicationContext(favoriteIds)
        }
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
        guard let url = URL(string: "https://letswift.kr/2025/assets/json/schedule.json") else {
            return .failure(URLError(.badURL))
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            if let httpResponse = response as? HTTPURLResponse,
               (200...299) ~= httpResponse.statusCode {
                let sessions = try jsonDecoder.decode([Session].self, from: data)
                // Filter only presentation type sessions
                let sessionItems = sessions
                    .filter { $0.type == "presentation" }
                    .map { SessionItem(from: $0) }
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
        let trackLower = track.lowercased()
        if trackLower.contains("트랙 a") || trackLower.contains("track a") || track == "A" || trackLower == "a" {
            return "A"
        } else if trackLower.contains("트랙 b") || trackLower.contains("track b") || track == "B" || trackLower == "b" {
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
        case .trackA: return "EMBER(B홀)"
        case .trackB: return "STAR(C홀)"
        }
    }
    
    var buttonText: String {
        switch self {
        case .trackA: return "C"
        case .trackB: return "B"
        }
    }
}

