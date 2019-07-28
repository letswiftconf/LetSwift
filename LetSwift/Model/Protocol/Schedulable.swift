//
//  Schedulable.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

protocol Schedulable {
    var title: String { get }
    var description: String { get }
    var location: String { get }
    var timespan: DateInterval { get }
}
