//
//  WelcomElement.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/12.
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable, Identifiable, Equatable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
    
    static func == (lhs: WelcomeElement, rhs: WelcomeElement) -> Bool {
            return lhs.id == rhs.id
        }
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String?
}

typealias Welcome = [WelcomeElement]

