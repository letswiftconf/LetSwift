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
    func initialize() {
        // Ensure loading state reflects actual async work duration.
        isLoading = true
        Task {
            let result = await fetchSessions()
            switch result {
            case .success(let sessions):
                update(sessions: sessions)
            case .failure:
                // Optionally handle error state here (e.g., set an alert)
                break
            }
            isLoading = false
        }
    }
    
    func fetchSessions() async -> Result<[Session], Error> {

        //        guard let url = URL(string: Constant.sessionURL) else {
        //            throw NSError()
        //        }
        //        let (data, response) = try await URLSession.shared.data(from: url)
        //        if let httpResponse = response as? HTTPURLResponse,
        //           (200...299) ~= httpResponse.statusCode {
        //            return try jsonDecoder.decode([Session].self, from: data)
        //        } else {
        //            throw NSError()
        //        }
        
        guard let url = Bundle.main.url(forResource: "Schedule", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return .failure(NSError())
        }
        
        do {
            let scheduleData = try jsonDecoder.decode([Session].self, from: data)
            return .success(scheduleData)
        } catch {
            return .failure(error)
        }
    }
    
    private func update(sessions: [Session]) {
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
