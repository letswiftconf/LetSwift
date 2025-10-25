//
//  CustomAlert+HomeExtensions.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
//

import SwiftUI

extension CustomAlert {
    static var saveEventSuccess: CustomAlert {
        CustomAlert(
            message: "행사 일정을 캘린더 등록하였어요.",
            primaryButton: CustomAlert.AlertButton(text: "확인")
        )
    }
    
    static var failedSaveEvent: CustomAlert {
        CustomAlert(
            message: "캘린더 등록에 실패하였어요.",
            primaryButton: CustomAlert.AlertButton(text: "확인")
        )
    }
    
    static var noPermission: CustomAlert {
        CustomAlert(
            message: "행사 일정 등록을 위해 캘린더 권한을 확인해 주세요.",
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
