//
//  UserDefaultsManager.swift
//  LetSwift
//
//  Created by Philip Chung on 9/22/24.
//

import Foundation

enum UserDefaultsKey: String {
    case savedSessions
    case sessions
}

@MainActor
struct UserDefaultsManager {
    @UserDefaultsWrapper(key: .savedSessions, defaultValue: Set<String>())
    static var savedSessions: Set<String>
    
    @UserDefaultsWrapper(key: .sessions, defaultValue: [Session]())
    static var sessions: [Session]
}
