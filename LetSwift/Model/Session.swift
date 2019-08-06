//
//  Session.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

struct Session: Schedulable, Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let speaker: Participant
    let location: String
    let timespan: DateInterval
    let track: Track
    let video: Video?
}
