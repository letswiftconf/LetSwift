//
//  NonSession.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

struct NonSession: Schedulable, Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let location: String
    let timespan: DateInterval
}
