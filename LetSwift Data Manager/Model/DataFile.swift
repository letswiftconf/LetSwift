//
//  DataFile.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 12/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

struct DataFile: Codable {
    let version = 1
    let conferences: [Conference]
    let sessions: [Session]
    let nonsessions: [NonSession]
    let profiles: [Profile]
    let participants: [Participant]
}
