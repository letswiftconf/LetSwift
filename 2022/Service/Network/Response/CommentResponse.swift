//
//  CommentResponse.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/16.
//

import Foundation

struct CommentResponse: Codable  {
    let size: Int?
    let cheerCard: Int?
    let contents: String?
    let guestBooks: [GuestBook]
}

// MARK: - GuestBook
struct GuestBook: Codable {
    var id = UUID()
    let cheerCard: Int?
    let contents: String?
}
