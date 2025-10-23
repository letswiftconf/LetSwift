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
        static let conferenceServeyURL = "https://docs.google.com/forms/d/e/1FAIpQLSeovrMzEaRbLqCR4IG7mkZQgHnrZ3OouXRzaRUsDclw6KqJvg/viewform?usp=sharing&ouid=117915791514720320713"
        static let festaURL = "https://festa.io/events/5772"
        static let eventURL = "https://letswift.kr/2024"
        static let newsletterSubscribeURL = "https://page.stibee.com/subscriptions/58654"

        // Push Notification Server
        static let pushServerBaseURL = "http://223.130.133.110:8080"
        static let deviceRegisterURL = "\(pushServerBaseURL)/device/register"
    }
    
    enum Notification {
        static let clickTypeUserInfoKey = "clickType"
        static let conferenceClosingDate: Date = Calendar.current.date(from: DateComponents(year: 2025, month: 11, day: 24, hour: 17, minute: 50, second: 0))!
    }
}
