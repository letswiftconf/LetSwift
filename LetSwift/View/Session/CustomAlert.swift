//
//  CustomAlert.swift
//  LetSwift
//
//  Created by Philip Chung on 9/23/24.
//

import SwiftUI

struct CustomAlert {
    let title: String?
    let message: String
    let primaryButton: AlertButton
    let secondaryButton: AlertButton?
    
    init(title: String? = nil, message: String, primaryButton: AlertButton, secondaryButton: AlertButton? = nil) {
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
    
    struct AlertButton {
        let text: String
        let role: ButtonRole?
        let action: (() -> Void)?
        
        init(text: String, role: ButtonRole? = nil, action: (() -> Void)? = nil) {
            self.role = role
            self.text = text
            self.action = action
        }
    }
}

extension CustomAlert {
    static var sessionAlreadyPassed: CustomAlert {
        CustomAlert(
            message: "이미 종료된 세션이에요.",
            primaryButton: CustomAlert.AlertButton(text: "확인")
        )
    }
    
    static var notificationPermissionDenied: CustomAlert {
        CustomAlert(
            message: "세션 알림을 예약하려면 알림 권한이 필요해요. 권한을 확인해 주세요.",
            primaryButton: CustomAlert.AlertButton(text: "확인", action: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            })
        )
    }
}
