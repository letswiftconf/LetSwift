//
//  SessionViewModel.swift
//  LetSwift
//
//  Created by Haeseok Lee on 9/2/24.
//

import Foundation
import SwiftUI
import UserNotifications

@Observable
final class SessionViewModel {
    
    var filteredSessions: [SessionRowViewModel] {
        switch currentTab {
        case .trackA:
            return sessions.filter { $0.trackEn == "Track A" }
        case .trackB:
            return sessions.filter { $0.trackEn == "Track B" }
        case .savedSession:
            return sessionRowViewModels.filter { $0.session.isSaved }
        }
    }
    
    init() {
        self.currentTab = .trackA
        self.isLoading = false
        self.sessionRowViewModels = []
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
        let sessionModels = sessions.map { SessionModel(from: $0) }
        let savedSessionIds: Set<String> = UserDefaultsManager.savedSessions
        let alarmedSessionids: Set<String> = UserDefaultsManager.alarmedSessions
        
        for (index, _) in sessionModels.enumerated() {
            // 저장한 세션 정보 반영
            if savedSessionIds.contains(sessionModels[index].identifier) {
                sessionModels[index].isSaved = true
            }
            
            // 알림 설정한 세션 정보 반영
            if alarmedSessionids.contains(sessionModels[index].identifier) {
                sessionModels[index].isAlarmed = true
            }
        }
        
        self.sessionRowViewModels = sessionModels.map { SessionRowViewModel(session: $0) }
    }
    
    func update(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func update(currentTab: SessionTab) {
        self.currentTab = currentTab
    }
}

private extension SessionViewModel {

    enum Constant {
        static let sessionURL: String = "https://api.bummo.dev/letswift2024/schedule"
        static let serverTimeFormat: String = "yyyy-MM-dd'T'HH:mm:ss"
    }
}
