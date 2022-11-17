//
//  SharedPreference+User.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/17.
//

import Foundation

extension SharedPreference {
    var user: ContentsResponse? {
        get {
            if let data = getObjectValues(key: PreferenceType.user.rawValue) as? Data {
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(ContentsResponse.self, from: data) {
                    return model
                }
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue){
                saveValues(key: PreferenceType.user.rawValue, values: encoded as AnyObject)
            }
        }
    }
}

