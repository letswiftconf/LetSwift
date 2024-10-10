//
//  UserDefaultsManager.swift
//  LetSwift
//
//  Created by Philip Chung on 9/22/24.
//

import Foundation

enum UserDefaultsKey: String {
    case savedSessions
    case alarmedSessions
}

struct UserDefaultsManager {
    @UserDefaultsWrapper(key: .savedSessions, defaultValue: Set<String>())
    static var savedSessions: Set<String>
    
    @UserDefaultsWrapper(key: .alarmedSessions, defaultValue: Set<String>())
    static var alarmedSessions: Set<String>
}
