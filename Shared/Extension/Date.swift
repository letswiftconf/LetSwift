//
//  Date.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/28.
//

import Foundation

extension Date {
    var readableDate: String {
        DateFormatter.dateFormatter().string(from: self)
    }
    
    var readableTime: String {
        DateFormatter.timeFormatter().string(from: self)
    }
    
    var readableDayOfWeek: String {
        DateFormatter.dayOfWeekFormatter().string(from: self)
    }
}
