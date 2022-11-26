//
//  DateFormatter.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/25.
//

import Foundation

extension DateFormatter {
    static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 (E)"
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
