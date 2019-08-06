//
//  Schedule.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

struct Schedule: Codable {
    let sessions: [Session]
    let nonsessions: [NonSession]
}
