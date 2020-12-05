//
//  UIApplication.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/05.
//  Copyright © 2019 Cleanios. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIApplication {
    var applicationName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
    var versionString: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        #if DEBUG
        return "\(version) (\(build)) Debug"
        #else
        return "\(version) (\(build))"
        #endif
    }
}
#else
import AppKit

extension NSApplication {
    var applicationName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
    var versionString: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        #if DEBUG
        return "\(version) (\(build)) Debug"
        #else
        return "\(version) (\(build))"
        #endif
    }
}
#endif
