//
//  Constants.swift
//  LetSwift
//
//  Created by Philip Chung on 9/18/24.
//

import Foundation

enum Constants {
    enum URL {
        static let sessionServeyURL = "https://forms.gle/spyNgx1bhoZ2uAMr7"
        static let conferenceServeyURL = "https://forms.gle/1ukqfXUBRTnw9hjf6"
    }
    
    enum Notification {
        static let clickTypeUserInfoKey = "clickType"
        static let conferenceClosingDate: Date = Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 25, hour: 17, minute: 20, second: 0))!
    }
}
