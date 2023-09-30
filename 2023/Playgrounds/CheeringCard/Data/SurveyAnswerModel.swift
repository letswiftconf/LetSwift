//
//  SurveyAnswerModel.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/07.
//

import Foundation

struct SurveyAnswerModel: Codable {
    var name: String
    var answer: [AnswerData]
    var session: String // 세션 정보 저장
}

struct AnswerData: Codable {
    var surveyId: Int
    var answer: Int
}
