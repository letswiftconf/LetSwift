//
//  UIColor.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/23.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

extension Color {
    static let themePrimary: Color = .themePrimary2020
    
    static let themePrimary2020 = Color(.themePrimary2020)
    static let themePrimary2019 = Color(.themePrimary2019)
    static let themeSecondary2019 = Color(.themeSecondary2019)
    static let themeBackground2019 = Color(.themeBackground2019)
    static let themePrimary2018 = Color(.themePrimary2018)
    
    // 2019
    static let timelineEvent = Color(.timelineEvent)
    static let timelineSession = Color(.timelineSession)
    static let timelineWorkshop = Color(.timelineWorkshop)
    static let timelineTeatime = Color(.timelineTeatime)
}

#if canImport(UIKit)
extension UIColor {
    static let themePrimary: UIColor = .themePrimary2020

    static let themePrimary2020 = UIColor(named: "2020_primary")!
    static let themePrimary2019 = UIColor(named: "2019_primary")!
    static let themeSecondary2019 = UIColor(named: "2019_secondary")!
    static let themeBackground2019 = UIColor(named: "2019_background")!
    static let themePrimary2018 = UIColor(named: "2018_primary")!
    
    static let timelineEvent = UIColor(named: "Timeline_Event")!
    static let timelineSession = UIColor(named: "Timeline_Session")!
    static let timelineWorkshop = UIColor(named: "Timeline_Workshop")!
    static let timelineTeatime = UIColor(named: "Timeline_Teatime")!
}
#endif
#if canImport(AppKit)
extension NSColor {
    static let themePrimary: Color = .themePrimary2020
    
    static let themePrimary2020 = NSColor(named: "2020_primary")!
    static let themePrimary2019 = NSColor(named: "2019_primary")!
    static let themeSecondary2019 = NSColor(named: "2019_secondary")!
    static let themeBackground2019 = NSColor(named: "2019_background")!
    static let themePrimary2018 = NSColor(named: "2018_primary")!
    
    static let timelineEvent = NSColor(named: "Timeline_Event")!
    static let timelineSession = NSColor(named: "Timeline_Session")!
    static let timelineWorkshop = NSColor(named: "Timeline_Workshop")!
    static let timelineTeatime = NSColor(named: "Timeline_Teatime")!
}
#endif
