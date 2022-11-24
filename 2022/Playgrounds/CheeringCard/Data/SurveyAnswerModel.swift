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
}

struct AnswerData: Codable {
    var surveyId: Int
    var answer: Int
}
