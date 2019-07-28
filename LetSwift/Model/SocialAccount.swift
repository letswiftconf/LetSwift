//
//  SocialAccount.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

struct SocialAccount {
    enum Category {
        case email
        case website
        case github
        case linkedin
        case facebook
        case instagram
        case twitter
        case unspecified
    }
    
    let category: SocialAccount.Category
    let url: URL
}
