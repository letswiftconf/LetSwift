//
//  SharedPreference.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/11.
//

import Foundation

class SharedPreference {
    static var shared = SharedPreference()
    
    enum PreferenceType: String {
        case comments
        case cheeringCard
        case myGuestBook
        case user
    }
    
    func saveValues(key: String, values: AnyObject){
        UserDefaults.standard.set(values, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getObjectValues(key:String ) -> AnyObject? {
        return UserDefaults.standard.object(forKey: key) as AnyObject?
    }
    
    func removeObjectValues(key:String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}

extension SharedPreference {
    var cheeringCard: CheeringCardModel? {
        get {
            if let data = getObjectValues(key: PreferenceType.cheeringCard.rawValue) as? Data {
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(CheeringCardModel.self, from: data) {
                    return model
                }
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue){
                saveValues(key: PreferenceType.cheeringCard.rawValue, values: encoded as AnyObject)
            }
        }
    }
    
    func remove() {
        removeObjectValues(key: PreferenceType.cheeringCard.rawValue)
    }
}
