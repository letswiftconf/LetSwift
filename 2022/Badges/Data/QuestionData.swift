//
//  QuestionData.swift
//  LetSwift
//
//  Created by Son on 2022/11/18.
//

import Foundation

struct QuestionData {
    var question: String
    var answer: String
    var isCorrect: Bool = false
    
    var session: QuestionSessionData
}

struct QuestionSessionData {
    var profile: String
    var datetime: String
    var title: String
    var contents: String
}

extension QuestionData {
    static var dummy : [QuestionData] = [
        QuestionData(question: "우리 행사이름 ?", answer: "letswift", session: .dummy),
        QuestionData(question: "multiline text test\nmultiline text test\nmultiline text test", answer: "lorem ipsum", session: .dummy),
        QuestionData(question: "swiftUI", answer: "반갑습니다", session: .dummy),
        QuestionData(question: "넓게넓게넓게쓰기넓게넓게넓게쓰기넓게넓게넓게쓰기넓게넓게넓게쓰기", answer: "반갑습니다", session: .dummy)
    ]
}

extension QuestionSessionData {
    static var dummy : QuestionSessionData = QuestionSessionData(
        profile: "손재구",
        datetime: "11:00 - 12:00",
        title: "letswift",
        contents: "letswift 행사 더미데이터 입니다"
    )
}
