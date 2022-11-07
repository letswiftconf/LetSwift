//
//  GuestBookModel.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/06.
//

import Foundation

struct GuestBooksModel:Codable {
    var guestBooks: [GuestBookModel]?
}

extension GuestBooksModel {
    static var mockingData: [GuestBookModel] {
        return [
            GuestBookModel(id: 1,content: "1만나서반갑습니다 만나서반갑습니다",profile: "calendar"),
            GuestBookModel(id: 2,content: "2렛츠스위프트와 함께하는 시간!",profile: "calendar"),
            GuestBookModel(id: 3,content: "3너무 기대됩니다.",profile: "calendar"),
            GuestBookModel(id: 4,content: "4유익한 세션들이 가득해요",profile: "calendar"),
            GuestBookModel(id: 5,content: "5어서 오세요",profile: "calendar"),
            GuestBookModel(id: 6,content: "6만나서 반갑습니다.",profile: "calendar")
        ]
    }
}

struct GuestBookModel: Identifiable, Codable {
    var id: Int?
    var content: String?
    var profile: String?
}
