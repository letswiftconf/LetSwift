//
//  SessionViewModel.swift
//  LetSwift
//
//  Created by Haeseok Lee on 9/2/24.
//

import Foundation
import SwiftUI

@Observable
final class SessionViewModel {
    
    var filteredSessions: [Session] {
        switch currentTab {
        case .trackA:
            return sessions.filter { $0.trackEn == "Track A" }
        case .trackB:
            return sessions.filter { $0.trackEn == "Track B" }
        case .savedSession:
            return sessions.filter { savedSessionIds.contains($0.id) }
        }
    }
    
    init() {
        self.currentTab = .trackA
        self.isLoading = false
        self.sessions = []
        self.savedSessionIds = Set(UserDefaults.standard.stringArray(forKey: Constant.savedSessionsKey) ?? [])
    }
    
    private(set) var currentTab: SessionTab
    private(set) var isLoading: Bool
    private(set) var sessions: [Session]
    private(set) var savedSessionIds: Set<String>
    
    @ObservationIgnored
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(serverTimeFormatter)
        return decoder
    }()
    
    @ObservationIgnored
    private let serverTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constant.serverTimeFormat
        return formatter
    }()
}

extension SessionViewModel {
    
    func fetchSessions() async throws -> [Session] {
        guard let url = URL(string: Constant.sessionURL) else {
            throw NSError()
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse,
           (200...299) ~= httpResponse.statusCode {
            return try jsonDecoder.decode([Session].self, from: data)
        } else {
            throw NSError()
        }
    }
    
    func update(sessions: [Session]) {
        self.sessions = sessions
    }
    
    func update(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func update(currentTab: SessionTab) {
        self.currentTab = currentTab
    }
    
    func toggleSavedSession(_ id: String) {
        if savedSessionIds.contains(id) {
            savedSessionIds.remove(id)
        } else {
            savedSessionIds.insert(id)
        }
        UserDefaults.standard.set(Array(savedSessionIds), forKey: Constant.savedSessionsKey)
    }
}

private extension SessionViewModel {
    
    enum Constant {
        static let sessionURL: String = "https://api.bummo.dev/letswift2024/schedule"
        static let savedSessionsKey: String = "savedSessions"
        static let serverTimeFormat: String = "yyyy-MM-dd'T'HH:mm:ss"
    }
}
