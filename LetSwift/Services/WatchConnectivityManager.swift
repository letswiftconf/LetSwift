//
//  WatchConnectivityManager.swift
//  LetSwift
//
//  Created by Auto on 12/19/24.
//

import Foundation
import WatchConnectivity

@MainActor
final class WatchConnectivityManager: NSObject {
    static let shared = WatchConnectivityManager()
    
    private let session: WCSession
    
    private override init() {
        self.session = WCSession.default
        super.init()
        
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
    func sendFavoriteIds(_ favoriteIds: Set<String>) {
        guard session.isReachable || session.isPaired else { return }
        
        do {
            let data = try JSONEncoder().encode(favoriteIds)
            let message: [String: Any] = [
                "favoriteIds": data,
                "timestamp": Date().timeIntervalSince1970
            ]
            session.sendMessage(message, replyHandler: nil) { error in
                print("❌ Failed to send favoriteIds: \(error.localizedDescription)")
            }
        } catch {
            print("❌ Failed to encode favoriteIds: \(error.localizedDescription)")
        }
    }
    
    func updateApplicationContext(_ favoriteIds: Set<String>) {
        guard session.activationState == .activated else { return }
        
        do {
            let data = try JSONEncoder().encode(favoriteIds)
            let context: [String: Any] = [
                "favoriteIds": data,
                "timestamp": Date().timeIntervalSince1970
            ]
            try session.updateApplicationContext(context)
        } catch {
            print("❌ Failed to update application context: \(error.localizedDescription)")
        }
    }
}

extension WatchConnectivityManager: WCSessionDelegate {
    nonisolated func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        Task { @MainActor in
            if let error = error {
                print("❌ WCSession activation failed: \(error.localizedDescription)")
            } else {
                print("✅ WCSession activated with state: \(activationState.rawValue)")
                // 앱 시작 시 현재 즐겨찾기 상태를 워치에 전송
                syncFavoriteIdsToWatch()
            }
        }
    }
    
    nonisolated func sessionDidBecomeInactive(_ session: WCSession) {
        print("⚠️ WCSession became inactive")
    }
    
    nonisolated func sessionDidDeactivate(_ session: WCSession) {
        print("⚠️ WCSession deactivated")
        Task { @MainActor in
            WCSession.default.activate()
        }
    }
    
    nonisolated func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // 필요한 데이터만 추출하여 @MainActor 컨텍스트로 안전하게 전달
        let favoriteIdsData = message["favoriteIds"] as? Data
        Task { @MainActor in
            if let data = favoriteIdsData {
                var messageCopy: [String: Any] = [:]
                messageCopy["favoriteIds"] = data
                handleReceivedMessage(messageCopy)
            }
        }
    }
    
    nonisolated func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        // 필요한 데이터만 추출하여 @MainActor 컨텍스트로 안전하게 전달
        let favoriteIdsData = applicationContext["favoriteIds"] as? Data
        Task { @MainActor in
            if let data = favoriteIdsData {
                var contextCopy: [String: Any] = [:]
                contextCopy["favoriteIds"] = data
                handleReceivedMessage(contextCopy)
            }
        }
    }
    
    @MainActor
    private func handleReceivedMessage(_ message: [String : Any]) {
        guard let data = message["favoriteIds"] as? Data,
              let favoriteIds = try? JSONDecoder().decode(Set<String>.self, from: data) else {
            return
        }
        
        // 워치에서 받은 즐겨찾기 데이터를 iOS 앱에 반영
        UserDefaultsManager.savedSessions = favoriteIds
        print("✅ Received favoriteIds from watch: \(favoriteIds.count) items")
        
        // NotificationCenter를 통해 UI 업데이트 알림
        NotificationCenter.default.post(name: .favoriteIdsDidUpdate, object: nil)
    }
    
    @MainActor
    private func syncFavoriteIdsToWatch() {
        let favoriteIds = UserDefaultsManager.savedSessions
        updateApplicationContext(favoriteIds)
    }
}

extension Notification.Name {
    static let favoriteIdsDidUpdate = Notification.Name("favoriteIdsDidUpdate")
}

