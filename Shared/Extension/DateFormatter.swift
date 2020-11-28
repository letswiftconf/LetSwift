//
//  DateFormatter.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/25.
//

import Foundation

extension DateFormatter {
    @available(*, deprecated)
    static func KSTDateFormatter(by format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }
    
    static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter
    }
    
    static func timeFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter
    }
    
    static func dayOfWeekFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter
    }
}
