//
//  Bundle.swift
//  LetSwift
//
//  Created by BumMo Koo on 10/2/25.
//

import Foundation

extension Bundle {
    static var appShortVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
    }

    static var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "--"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "--"
#if DEBUG
        return "\(version) (Dev Build \(build))"
#else
        return "\(version) (Build \(build))"
#endif
    }

    static var appName: String {
        let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        return name ?? "Let'Swift"
    }
}
