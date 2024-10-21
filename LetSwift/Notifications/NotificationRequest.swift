//
//  NotificationRequest.swift
//  LetSwift
//
//  Created by Philip Chung on 9/18/24.
//

import Foundation

struct NotificationRequest {
    let identifier: String
    let body: String
    let sendDate: Date
    let userInfo: [AnyHashable: Any]?
}

extension NotificationRequest {
    init(type: SessionNotificationType, sessionModel: SessionModel) {
        switch type {
        case .begin:
            self.identifier = sessionModel.alarmBeginNotificationIdentifier
            self.body = "📣 \(sessionModel.name) \(sessionModel.speaker?.name ?? "") 곧 시작됩니다! 원활한 진행을 위해 자리에 착석해 주세요."
            self.sendDate = sessionModel.startTime.addingTimeInterval(-10 * 60)
            self.userInfo = nil
        case .end:
            self.identifier = sessionModel.alarmEndNotificationIdentifier
            self.body = "💌 \(sessionModel.name) \(sessionModel.speaker?.name ?? "") 어떠셨나요? 세션에 대한 소중한 의견을 설문을 남겨주세요."
            self.sendDate = sessionModel.endTime
            self.userInfo = [
                Constants.Notification.clickTypeUserInfoKey : NotificationClickType.openUrl(url: Constants.URL.sessionServeyURL).dictionary
            ]
        }
    }
}

extension NotificationRequest {
    static var conferenceClosingNotification: NotificationRequest {
        return NotificationRequest(
            identifier: "conference_closing",
            body: "Let'Swift 2024 설문조사에 참여해주세요!",
            sendDate: Constants.Notification.conferenceClosingDate.addingTimeInterval(10 * 60),
            userInfo: [
                Constants.Notification.clickTypeUserInfoKey : NotificationClickType.openUrl(url: Constants.URL.conferenceServeyURL).dictionary
            ]
        )
    }
}
