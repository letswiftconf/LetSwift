//
//  SettingsViewModel.swift
//  LetSwift
//
//  Created by Philip Chung on 9/5/24.
//

import Foundation
import SwiftUI

final class SettingsViewModel {
    private let settings: Settings = Settings.data
    
    var sections: [Settings.Section] {
        return self.settings.sections
    }
    
    var numberOfSections: Int {
        return settings.sections.count
    }
}
