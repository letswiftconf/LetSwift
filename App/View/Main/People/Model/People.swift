//
//  People.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/23.
//

import SwiftUI
import Combine

final class People: ObservableObject {
    @Published var list: [Person]
    var type: PersonType
    var title: String {
        switch type {
        case .organizer:
            return "Organizer"
        case .panels:
            return "Panels"
        case .staff:
            return "Staff"
        }
    }
    
    init(type: PersonType) {
        self.type = type
        switch type {
        case .organizer:
            list = Person.makeOrganizer()
        case .panels:
            list = Person.makePanels()
        case .staff:
            list = Person.makeStaff()
        }
    }
}
