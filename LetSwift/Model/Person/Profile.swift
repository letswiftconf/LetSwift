//
//  Profile.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

// MARK: - Profile
/// A person's information. This class should only contain unchanging information about a person.
/// e.g. A person's profile image and description may change in different `Conference`. These properties should be in `Participant`.
class Profile: Identifiable, Codable, ObservableObject {
    let id = UUID()
    var familyName: String { willSet { objectWillChange.send() } }
    var givenName: String { willSet { objectWillChange.send() } }
    var nickname: String { willSet { objectWillChange.send() } }
    
    var preferredName: String {
        var components = PersonNameComponents()
        components.givenName = givenName
        components.familyName = familyName
        components.nickname = nickname
        
        let formatter = PersonNameComponentsFormatter()
        formatter.style = nickname.count == 0 ? .default : .short
        let name = formatter.string(from: components)
        return name.count != 0 ? name : "Unnamed Man"
    }
    
    // MARK: - Initialization
    init(familyName: String,
         givenName: String,
         nickname: String = "") {
        self.familyName = familyName
        self.givenName = givenName
        self.nickname = nickname
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case id, familyName, givenName, nickname
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
}

// MARK: - Equatable & Hashable
extension Profile: Hashable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
