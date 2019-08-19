//
//  OSLog.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 10/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
    // MARK: - Log
    static var `default`: OSLog {
        return log(category: "default")
    }
    
    // MARK: - Helper
    private static func log(category: String) -> OSLog {
        let identifier = Bundle.main.bundleIdentifier ?? "kr.codesquad.LetSwift-Data-Manager"
        return OSLog(subsystem: identifier, category: category)
    }
}
