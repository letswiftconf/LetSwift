//
//  SharedPreference+.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/12.
//

import Foundation

extension SharedPreference {
    var comments: CommentResponse? {
        get {
            if let data = getObjectValues(key: PreferenceType.comments.rawValue) as? Data {
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(CommentResponse.self, from: data) {
                    return model
                }
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue){
                saveValues(key: PreferenceType.comments.rawValue, values: encoded as AnyObject)
            }
        }
    }
}
