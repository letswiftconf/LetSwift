//
//  ProfileData.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/10.
//

import Foundation

struct ProfileData {
    static var speakerList: [Profile] = []
    static var supporterList: [Profile] = []
    static var staffList: [Profile] = []
    
    static func changeToProfileModel(profileAPIDataList: [ProfileAPIData]) -> [Profile] {
        var profileList: [Profile] = []
        for profileAPIData in profileAPIDataList {
            var snsList: [SNSCategory] = []
            
            if let email = profileAPIData.email {
                snsList.append(.email(email))
            }
            
            if let sns = profileAPIData.sns {
                snsList.append(.SNS(sns))
            }
            
            if let github = profileAPIData.github {
                snsList.append(.gitHub(github))
            }
            
            if let linkedIn = profileAPIData.linkedIn {
                snsList.append(.linkedIn(linkedIn))
            }
            
            let profile = Profile(name: profileAPIData.name ?? "", role: ProfileRole(profileRole: profileAPIData.role ?? "")!, description: profileAPIData.description ?? "", sns: snsList)
            if !profileList.contains(profile) {
                profileList.append(profile)
            }
        }
        return profileList
    }
}
