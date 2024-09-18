//
//  UserDefaultsWrapper.swift
//  LetSwift
//
//  Created by Philip Chung on 9/22/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    private let key: UserDefaultsKey
    private let defaultValue: T
    private let standard: UserDefaults = UserDefaults.standard
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = self.standard.object(forKey: key.rawValue) as? Data else { return defaultValue }
            let session = try? JSONDecoder().decode(T.self, from: data)
            return session ?? defaultValue
        }
        
        set {
            let data = try? JSONEncoder().encode(newValue)
            self.standard.set(data, forKey: self.key.rawValue)
        }
    }
}
