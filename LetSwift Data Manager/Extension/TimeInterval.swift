//
//  TimeInterval.swift
//  LetSwift Data Manager
//
//  Created by 김나용 on 30/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    // MARK: - Static
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
    
    // MARK: - Initialization
    init(_ hhmmss: HHMMSS) {
        self.init(hhmmss.timeInterval)
    }
    
    // MARK: - Computed variables
    var hhmmss: HHMMSS {
        return HHMMSS(hours: Double(hours),
                      minutes: Double(minutes % 60),
                      seconds: Double(seconds % 60))
    }
    
    var hours: Int {
        return Int(self / TimeInterval.secondsPerHour)
    }
    
    var minutes: Int {
        return Int(self / TimeInterval.secondsPerMinute)
    }
    
    var seconds: Int {
        return Int(self)
    }
}

// MARK: - HHMMSS
struct HHMMSS {
    
    // MARK: - Properties
    var hours: Double
    var minutes: Double
    var seconds: Double

    // MARK: - Computed Variables
    var timeInterval: TimeInterval {
        return TimeInterval.hours(hours)
            + TimeInterval.minutes(minutes)
            + TimeInterval.seconds(seconds)
    }
    
    var string: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: timeInterval) ?? ""
    }
}
