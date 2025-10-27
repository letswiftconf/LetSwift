//
//  HapticFeedback.swift
//  LetSwift-watchOS Watch App
//
//  Created by Coby on 11/25/24.
//

import WatchKit

class HapticFeedback {
    static func play(_ type: WKHapticType) {
        WKInterfaceDevice.current().play(type)
    }
    
    static func notification() {
        WKInterfaceDevice.current().play(.notification)
    }
    
    static func click() {
        WKInterfaceDevice.current().play(.click)
    }
}

