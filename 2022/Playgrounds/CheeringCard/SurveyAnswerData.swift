//
//  SurveyAnswerData.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/07.
//

import Foundation

struct SurveyAnswerData {
    var name: String
    var answer: [(surveyId: Int, answerId: Int)]
}

struct TempAnswerData {
    static let answerData =
    SurveyAnswerData(name: "지인",
                     answer: [
                        (surveyId: 1, answerId: 2),
                        (surveyId: 2, answerId: 3),
                        (surveyId: 3, answerId: 1),
                        (surveyId: 4, answerId: 2),
                        (surveyId: 5, answerId: 4),
                     ])
    
}

//@EnvironmentObject private var people: People
