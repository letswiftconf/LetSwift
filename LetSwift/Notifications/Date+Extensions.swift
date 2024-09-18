//
//  Date+Extensions.swift
//  LetSwift
//
//  Created by Philip Chung on 9/23/24.
//

import Foundation

extension Date {
    var dateComponent: DateComponents {
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.year = calendar.component(.year, from: self)
        dateComponents.month = calendar.component(.month, from: self)
        dateComponents.day = calendar.component(.day, from: self)
        dateComponents.hour = calendar.component(.hour, from: self)
        dateComponents.minute = calendar.component(.minute, from: self)
        
        return dateComponents
    }
    
    private var calendar: Calendar { Calendar.current }
}
