//
//  MoreViewModel.swift
//  LetSwift
//
//  Created by Philip Chung on 9/5/24.
//

import Foundation
import SwiftUI

final class MoreViewModel {
    private let contents: More = More.data
    
    var sections: [More.Section] {
        return self.contents.sections
    }
    
    var numberOfSections: Int {
        return contents.sections.count
    }
}
