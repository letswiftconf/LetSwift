//
//  SessionViewModel.swift
//  LetSwift
//
//  Created by Haeseok Lee on 9/2/24.
//

import Foundation
import SwiftUI
import UserNotifications
import UIKit
import ActivityKit

@MainActor
@Observable
final class SessionViewModel {
    var filteredSessions: [SessionRowViewModel] {
        switch currentTab {
        case .ember:
            return sessionRowViewModels.filter { $0.session.track == "A" }
        case .star:
            return sessionRowViewModels.filter { $0.session.track == "B" }
        case .savedSession:
            return sessionRowViewModels.filter { $0.session.isSaved }
        }
    }
    
    init() {
        self.currentTab = .ember
        self.isLoading = false
        self.isLoaded = false
        self.sessionRowViewModels = []
        
        // WatchConnectivity를 통해 워치에서 받은 즐겨찾기 업데이트를 반영
        NotificationCenter.default.addObserver(
            forName: .favoriteIdsDidUpdate,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor [self] in
                self.updateFavoriteStates()
            }
        }
    }

    private(set) var currentTab: SessionTab
    private(set) var isLoading: Bool
    private(set) var isLoaded: Bool
    private(set) var sessionRowViewModels: [SessionRowViewModel]
    private(set) var showPermissionAlert: Bool = false
    private(set) var showSuccessAlert: Bool = false
    private(set) var showErrorAlert: Bool = false
    
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
        guard !isLoaded, !isLoading else { return }
        isLoading = true
        Task {
            let sessions = await loadSessions()
            switch sessions {
            case .success(let success):
                update(sessions: success)
                isLoaded = true
            case .failure(_):
                let cached = UserDefaultsManager.sessions
                update(sessions: cached)
            }
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
    
    private func updateFavoriteStates() {
        let savedSessionIds: Set<String> = UserDefaultsManager.savedSessions
        
        for viewModel in sessionRowViewModels {
            let shouldBeSaved = savedSessionIds.contains(viewModel.session.identifier)
            if viewModel.session.isSaved != shouldBeSaved {
                viewModel.session.isSaved = shouldBeSaved
            }
        }
    }

    func update(currentTab: SessionTab) {
        self.currentTab = currentTab
    }

    func startLiveActivityAction() async {
        // First, end all existing Live Activities
        await endAllLiveActivities()

        // Check push notification permission
        let hasPermission = await checkNotificationPermission()
        if hasPermission {
            await startLiveActivity()
        } else {
            // Request permission
            let granted = await requestNotificationPermission()
            if granted {
                await startLiveActivity()
            } else {
                // Show alert to guide user to settings
                showPermissionAlert = true
            }
        }
    }

    func autoStartLiveActivityIfNeeded() async {
        // Skip if already running
        if !Activity<PresentationAttributes>.activities.isEmpty {
            print("✅ Live Activity already running, skipping auto-start")
            return
        }

        print("🚀 Auto-starting Live Activity...")

        // Check push notification permission
        let hasPermission = await checkNotificationPermission()
        if hasPermission {
            await startLiveActivity(showAlert: false)  // Don't show alert for auto-start
        } else {
            // Don't request permission for auto-start, just skip silently
            print("⚠️ Push notification permission not granted, skipping auto-start")
        }
    }

    private func checkNotificationPermission() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus == .authorized
    }

    private func requestNotificationPermission() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            return granted
        } catch {
            print("❌ Failed to request notification permission: \(error)")
            return false
        }
    }

    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
        showPermissionAlert = false
    }

    func dismissPermissionAlert() {
        showPermissionAlert = false
    }

    func dismissSuccessAlert() {
        showSuccessAlert = false
    }

    func dismissErrorAlert() {
        showErrorAlert = false
    }

    private func endAllLiveActivities() async {
        for activity in Activity<PresentationAttributes>.activities {
            await activity.end(nil, dismissalPolicy: .immediate)
            print("🛑 Ended existing Live Activity: \(activity.attributes.track)")
        }
    }

    private func startLiveActivity(showAlert: Bool = true) async {
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {
            print("❌ No device ID found")
            if showAlert {
                showErrorAlert = true
            }
            return
        }

        let request: [String: Any] = [
            "deviceIds": [deviceId]
        ]

        guard let url = URL(string: Constants.URL.liveActivityStartCurrentURL) else {
            print("❌ Invalid URL")
            if showAlert {
                showErrorAlert = true
            }
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: request)
            let (_, response) = try await URLSession.shared.data(for: urlRequest)

            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) {
                print("✅ Live Activities started for both tracks")
                if showAlert {
                    showSuccessAlert = true
                }
            } else {
                print("❌ Failed to start Live Activities")
                if showAlert {
                    showErrorAlert = true
                }
            }
        } catch {
            print("❌ Error starting Live Activities: \(error)")
            if showAlert {
                showErrorAlert = true
            }
        }
    }
}

private extension SessionViewModel {
    enum Constant {
        static let sessionURL: String = "https://letswift.kr/2025/assets/json/schedule.json"
        static let serverTimeFormat: String = "yyyy-MM-dd'T'HH:mm:ss"
    }
}

extension SessionViewModel {
    private func loadSessions() async -> Result<[Session], Error> {
        do {
            let fetched = try await fetchSessions()
            UserDefaultsManager.sessions = fetched
            return Result.success(fetched)
        } catch {
            return Result.failure(error)
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
            // Filter only presentation type sessions
            return decoded.filter { $0.type == "presentation" }
        } else {
            throw NSError()
        }
    }
}
