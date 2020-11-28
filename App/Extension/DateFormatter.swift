//
//  DateFormatter.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/25.
//

import Foundation

extension DateFormatter {
    static func KSTDateFormatter(by format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        
        return dateFormatter
    }
}
