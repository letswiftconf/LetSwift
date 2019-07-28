//
//  Profile.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

struct Profile {
    let name: (family: String, given: String)?
    let nickname: String?
    let description: String
    let imageUrl: URL?
    let socialAccounts: [SocialAccount]
    
    var preferredName: String {
        var components = PersonNameComponents()
        components.givenName = name?.given
        components.familyName = name?.family
        components.nickname = nickname
        
        let formatter = PersonNameComponentsFormatter()
        formatter.style = nickname == nil ? .default : .short
        let name = formatter.string(from: components)
        return name.count != 0 ? name : "Unnamed Man"
    }
}
