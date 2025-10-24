//
//  SessionViewModel.swift
//  LetSwift
//
//  Created by Haeseok Lee on 9/2/24.
//

import Foundation
import SwiftUI
import UserNotifications

@MainActor
@Observable
final class SessionViewModel {
    var filteredSessions: [SessionRowViewModel] {
        switch currentTab {
        case .trackA:
            return sessionRowViewModels.filter { $0.session.track == "A" }
        case .trackB:
            return sessionRowViewModels.filter { $0.session.track == "B" }
        case .savedSession:
            return sessionRowViewModels.filter { $0.session.isSaved }
        }
    }
    
    init() {
        self.currentTab = .trackA
        self.isLoading = false
        self.sessionRowViewModels = []
        load()
    }
    
    private(set) var currentTab: SessionTab
    private(set) var isLoading: Bool
    private(set) var sessionRowViewModels: [SessionRowViewModel]
    
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
    func load() {
        isLoading = true
        Task {
            let sessions = await loadSessions()
            update(sessions: sessions)
            isLoading = false
        }
    }
    
    private func update(sessions: [Session]) {
        let sessionModels = sessions.map { SessionModel(from: $0) }
        let savedSessionIds: Set<String> = UserDefaultsManager.savedSessions
        
        for (index, _) in sessionModels.enumerated() {
            // 저장한 세션 정보 반영
            if savedSessionIds.contains(sessionModels[index].identifier) {
                sessionModels[index].isSaved = true
            }
        }
        
        self.sessionRowViewModels = sessionModels.map { SessionRowViewModel(session: $0) }
    }

    func update(currentTab: SessionTab) {
        self.currentTab = currentTab
    }
}

private extension SessionViewModel {
    enum Constant {
        static let sessionURL: String = "http://223.130.133.110:8080/presentations"
        static let serverTimeFormat: String = "yyyy-MM-dd'T'HH:mm:ss"
    }
}

extension SessionViewModel {
    private func loadSessions() async -> [Session] {
        do {
            let fetched = try await fetchSessions()
            UserDefaultsManager.sessions = fetched
            return fetched
        } catch {
            let cached = UserDefaultsManager.sessions
            return cached
        }
    }
    
    private func fetchSessions() async throws -> [Session] {
        guard let url = URL(string: Constant.sessionURL) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse,
           (200...299) ~= httpResponse.statusCode {
            let decoded = try jsonDecoder.decode([Session].self, from: data)
            return decoded
        } else {
            throw NSError()
        }
    }
}
