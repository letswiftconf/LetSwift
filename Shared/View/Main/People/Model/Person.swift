//
//  Person.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/23.
//

import Foundation

struct Person: Hashable, Identifiable {
    let id: UUID = UUID()
    let imageName: String
    let name: String
    let organization: String?
    let role: [String]
    let description: String
}

enum PersonType {
    case organizer
    case panels
    case staff
}

extension Person {
    static func makeOrganizer() -> [Person] {
        return [Person(imageName: "Placeholder", name: "organizer", organization: nil, role: ["organizer"], description: "I'm organizer")]
    }
    
    static func makePanels() -> [Person] {
        return (1...6).map { return Person(imageName: "Placeholder", name: "panel\($0)", organization: "organization\($0)", role: ["panel"], description: "I'm panel\($0)") }
    }
    
    static func makeStaff() -> [Person] {
        return (1...4).map { Person(imageName: "Placeholder", name: "staff\($0)", organization: "organization\($0)", role: ["staff"], description: "I'm staff\($0)") }
    
    static func makeDummy() -> Person {
        return Person(imageName: "Placeholder", name: "", organization: "", role: [], description: "")
    }
}
