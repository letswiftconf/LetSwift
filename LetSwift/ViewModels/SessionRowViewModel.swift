//
//  SessionRowViewModel.swift
//  LetSwift
//
//  Created by Philip Chung on 9/21/24.
//

import Foundation

@MainActor
@Observable
final class SessionRowViewModel {
    private(set) var session: SessionModel
    
    init(session: SessionModel) {
        self.session = session
    }
}

// MARK: - Image
extension SessionRowViewModel {
    var bookmarkImageString: String {
        return session.isSaved ? "heart.fill" : "heart"
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
}
