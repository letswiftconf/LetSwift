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
            body: "Let'Swift 2025 행사가 즐거우셨나요?\n소중한 의견을 위해 설문조사에 참여해주세요!",
            sendDate: Constants.Notification.conferenceClosingDate.addingTimeInterval(10 * 60),
            clickType: .openUrl(url: Constants.URL.conferenceServeyURL)
        )
    }
}

