//
//  ProtoPerson.swift
//  LetSwift
//
//  Created by 김나용 on 2019/10/16.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

protocol Person: Hashable, Identifiable {
    var name: String { get set }
    var userID: String { get set }
    var organization: String { get set }
    var tags: [String] { get set }
    var description: String { get set }
    var imageName: String { get set }
}

class SuperPerson: Person {
    let id = UUID()
    var name: String
    var userID: String = ""
    var imageName: String = ""
    var organization: String
    var description: String
    var tags: [String] = []
    
    init(name: String, organization: String, description: String, tags: [String] = []) {
        self.name = name
        self.userID = name
        self.imageName = name
        self.organization = organization
        self.description = description
        self.tags = tags
    }
    
    static func == (lhs: SuperPerson, rhs: SuperPerson) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
