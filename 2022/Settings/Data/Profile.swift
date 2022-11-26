//
//  Profile.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/10.
//

import Foundation

struct Profile: Hashable, Identifiable, Equatable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: UUID = UUID()
    let imageName: String
    let name: String
    let role: ProfileRole
    let description: String
    let sns: [SNSCategory]
    
    init(name: String, role: ProfileRole, description: String, sns: [SNSCategory]) {
        self.name = name
        self.imageName = "2022_\(name)"
        self.role = role
        self.description = description
        self.sns = sns
    }
}

enum ProfileRole: String, Hashable, CaseIterable {
    init?(profileRole: String) {
        if profileRole == "speaker" {
            self = .speaker
        } else if profileRole == "staff" {
            self = .staff
        } else if profileRole == "supporter" {
            self = .supporter
        } else {
            self = .noRole
        }
    }
    
    case speaker
    case staff
    case supporter
    case noRole
    
//    var localizedString: String {
//        switch self {
//            case .speakers:
//                return "앱 개발"
//            case .staff:
//                return "Organizer"
//            case .sponsor:
//                return "행사 기획"
//        }
//    }
}

enum SNSCategory: Hashable {
    case email(String)
    case gitHub(String)
    case twitter(String)
    case blog(String)
    case linkedIn(String)
    case SNS(String)
    
    var localizedString: String {
        switch self {
            case .email(_):
                return "Email"
            case .blog(_):
                return "Blog"
            case .gitHub(_):
                return "GitHub"
            case .twitter(_):
                return "Twitter"
            case .linkedIn(_):
                return "LinkedIn"
            case .SNS(_):
                return "SNS"
        }
    }
}
