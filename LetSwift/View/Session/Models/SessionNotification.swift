//
//  SessionNotification.swift
//  LetSwift
//
//  Created by Philip Chung on 10/6/24.
//

import Foundation

enum SessionNotificationType: String {
    case begin
    case end
}

struct SessionNotification {
    let id: String  // notification id
    let date: Date  // notification push date
    let type: SessionNotificationType
    let body: String
    
    init(id: String, date: Date, type: SessionNotificationType, body: String) {
        self.id = "\(id)-\(type.rawValue)"
        self.date = date
        self.type = type
        self.body = body
    }
}
