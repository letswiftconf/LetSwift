//
//  Constants.swift
//  LetSwift
//
//  Created by Philip Chung on 9/18/24.
//

import Foundation

enum Constants {
    /// Details of the current conference. Update this when preparing the next year's app.
    enum Conference {
        static let year = 2025
        static let name = "Let'Swift \(year)"
        static let slogan = "Ember to Stars!"
        static let location = "서울 광진구 능동로 209"
        static let timeZone = TimeZone(identifier: "Asia/Seoul")!
        static let startDate = date(month: 11, day: 24, hour: 10)
        static let endDate = date(month: 11, day: 24, hour: 16)
        /// When the closing session ends; the survey notification is sent shortly after.
        static let closingDate = date(month: 11, day: 24, hour: 17, minute: 50)

        /// Whether the conference has already ended.
        static var isOver: Bool {
            Date.now > closingDate
        }

        private static func date(month: Int, day: Int, hour: Int, minute: Int = 0) -> Date {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = timeZone
            return calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute))!
        }
    }

    enum URL {
        static let sessionSurveyURL = "https://forms.gle/spyNgx1bhoZ2uAMr7"
        static let conferenceSurveyURL = "https://docs.google.com/forms/d/e/1FAIpQLSeovrMzEaRbLqCR4IG7mkZQgHnrZ3OouXRzaRUsDclw6KqJvg/viewform?usp=sharing&ouid=117915791514720320713"
        static let festaURL = "https://festa.io/events/5772"
        static let eventURL = "https://letswift.kr/\(Conference.year)"
        static let newsletterSubscribeURL = "https://page.stibee.com/subscriptions/58654"
    }
    
    enum Notification {
        static let clickTypeUserInfoKey = "clickType"
    }
}
