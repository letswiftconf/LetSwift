//
//  APIModel.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/18.
//

import Foundation

struct ProfileAPIData: Codable {
    let name: String?
    let profile: String?
    let description: String?
    let role: String?
    let email: String?
    let sns: String?
    let github: String?
    let linkedIn: String?
}
