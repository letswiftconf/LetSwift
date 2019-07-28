//
//  Person.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

struct Person {
    enum Category {
        case organizer
        case speaker
        case staff
        case unspecified
    }
    
    let category: Person.Category
    let profile: Profile
}
