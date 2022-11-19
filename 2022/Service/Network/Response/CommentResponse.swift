//
//  CommentResponse.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/16.
//

import Foundation

struct CommentResponse: Codable  {
    let size: Int?
    let cheerCardNumber: Int?
    let contents: String?
    let guestBooks: [GuestBook]
}

// MARK: - GuestBook
struct GuestBook: Codable, Hashable{
    let cheerCardNumber: Int?
    let contents: String?
}
