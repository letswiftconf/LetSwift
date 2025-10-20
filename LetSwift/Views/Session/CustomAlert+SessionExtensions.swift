//
//  CustomAlert.swift
//  LetSwift
//
//  Created by Philip Chung on 9/23/24.
//

import SwiftUI

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
                Task { @MainActor in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
            })
        )
    }
}
