//
//  OSLog .swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
    // MARK: - Log
    static var `default`: OSLog {
        return log(category: "default")
    }
    
    static var network: OSLog {
        return log(category: "network")
    }
    
    // MARK: - Helper
    private static func log(category: String) -> OSLog {
        let identifier = Bundle.main.bundleIdentifier ?? "kr.codesquad.jk.letswift"
        return OSLog(subsystem: identifier, category: category)
    }
}
