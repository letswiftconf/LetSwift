//
//  SharedPreference+.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/12.
//

import Foundation

extension SharedPreference {
    var welcome: Welcome? {
        get {
            if let data = getObjectValues(key: PreferenceType.welcome.rawValue) as? Data {
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(Welcome.self, from: data) {
                    return model
                }
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue){
                saveValues(key: PreferenceType.welcome.rawValue, values: encoded as AnyObject)
            }
        }
    }
}
