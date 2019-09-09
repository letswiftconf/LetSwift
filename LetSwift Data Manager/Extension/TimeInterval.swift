//
//  TimeInterval.swift
//  LetSwift Data Manager
//
//  Created by 김나용 on 30/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    // MARK: - Static functions
    static let secondsPerHour: TimeInterval = 60 * 60
    static let secondsPerMinute: TimeInterval = 60
    
    static func hours(_ value: Double) -> TimeInterval {
        return value * Double(secondsPerHour)
    }
    
    static func minutes(_ value: Double) -> TimeInterval {
        return value * Double(secondsPerMinute)
    }
    
    static func seconds(_ value: Double) -> TimeInterval {
        return value
    }
    
    // MARK: - Computed variables
    var hhmmss: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: self) ?? ""
    }
}
