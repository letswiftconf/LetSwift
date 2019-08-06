//
//  Event.swift
//  LetSwift
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

struct Event: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: Date
    
    let schedule: Schedule
    let organizers: [Participant]
    let staff: [Participant]
    let speakers: [Participant]
}
