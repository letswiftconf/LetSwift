//
//  SessionRowViewModel.swift
//  LetSwift
//
//  Created by Philip Chung on 9/21/24.
//

import Foundation

@Observable
final class SessionRowViewModel {
    private(set) var session: SessionModel
    var alert: CustomAlert?
    
    init(session: SessionModel) {
        self.session = session
        self.alert = nil
    }
}

// MARK: - Image
extension SessionRowViewModel {
    var bookmarkImageString: String {
        return session.isSaved ? "bookmark.fill" : "bookmark"
    }
    
    var alarmImageString: String {
        return session.isAlarmed ? "bell.fill" : "bell"
    }
}

// MARK: - Action
extension SessionRowViewModel {
    func onToggleBookmark() {
        session.isSaved.toggle()
        
        var savedSessions: Set<String> = UserDefaultsManager.savedSessions
        // Set에 값이 없으면 추가. 있으면 Set에서 제거.
        savedSessions = savedSessions.symmetricDifference([session.identifier])
        UserDefaultsManager.savedSessions = savedSessions
    }
    
    func onToggleAlarm() async {
        if !session.isAlarmed && Date.now >= session.endTime {
            self.alert = CustomAlert.sessionAlreadyPassed
            return
        }
        
        guard await NotificationManager.shared.isAuthorized() else {
            self.alert = CustomAlert.notificationPermissionDenied
            return
        }
        
        session.isAlarmed.toggle()
        
        // UserDefaults Set에서 정보 업데이트 후 로컬 푸시 등록/제거
        var alarmedSessions: Set<String> = UserDefaultsManager.alarmedSessions
        
        if alarmedSessions.contains(session.identifier) {
            alarmedSessions.remove(session.identifier)
            await NotificationManager.shared.removeNotification(identifiers: session.alarmNotificationIdentifiers)
        } else {
            alarmedSessions.insert(session.identifier)
            try? await NotificationManager.shared.registerNotification(NotificationRequest(type: .begin, sessionModel: session))
            try? await NotificationManager.shared.registerNotification(NotificationRequest(type: .end, sessionModel: session))
        }
        
        UserDefaultsManager.alarmedSessions = alarmedSessions
    }
}
