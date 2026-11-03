//
//  NotificationRequest.swift
//  LetSwift
//
//  Created by Philip Chung on 9/18/24.
//

import Foundation

struct NotificationRequest: Sendable {
    let identifier: String
    let body: String
    let sendDate: Date
    // Strongly-typed, Sendable userInfo instead of [AnyHashable: Any]?
    let clickType: NotificationClickType?
}

extension NotificationRequest {
    static var conferenceClosingNotification: NotificationRequest {
        return NotificationRequest(
            identifier: "conference_closing",
            body: String(localized: "notification.survey.body \(Constants.Conference.name)"),
            sendDate: Constants.Conference.closingDate.addingTimeInterval(10 * 60),
            clickType: .openUrl(url: Constants.URL.conferenceSurveyURL)
        )
    }
}

