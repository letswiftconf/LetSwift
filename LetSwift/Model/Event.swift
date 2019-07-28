//
//  Event.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

struct Event: Schedulable {
    let title: String
    let description: String
    let location: String
    let timespan: DateInterval
}
