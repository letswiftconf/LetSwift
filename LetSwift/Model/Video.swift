//
//  Video.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

struct Video: Codable, Identifiable {
    let id = UUID()
    let length: TimeInterval
    let url: URL
}
