//
//  CustomAlert.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
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
