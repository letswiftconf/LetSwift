//
//  Track.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

struct Track: Identifiable {
    enum Category: String {
        case session
        case workshop
    }
    
    let id = UUID()
    let category: Track.Category
}
