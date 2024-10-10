//
//  View+Extensions.swift
//  LetSwift
//
//  Created by Philip Chung on 9/23/24.
//

import SwiftUI

extension View {
    func customAlert(_ alert: Binding<CustomAlert?>) -> some View {
        let alertInfo = alert.wrappedValue
        
        return self.alert(alertInfo?.title ?? "", isPresented: .constant(alertInfo != nil)) {
            Button(alertInfo?.primaryButton.text ?? "", role: alertInfo?.primaryButton.role) {
                alertInfo?.primaryButton.action?()
                alert.wrappedValue = nil
            }
            
            if let secondaryButton = alertInfo?.secondaryButton {
                Button(secondaryButton.text, role: secondaryButton.role) {
                    secondaryButton.action?()
                    alert.wrappedValue = nil
                }
            }
        } message: {
            Text(alertInfo?.message ?? "")
        }
    }
}
