//
//  SurveyData.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/04.
//

import Foundation

struct SurveyData {
    var surveyId: Int
    var question: String
    var answer: [(answerId: Int, answer: String)]
}

struct TempChartData {
    static let questionList = [
        SurveyData(
            surveyId: 1,
            question: "Let’Swift 2022 컨퍼런스에 참여하게 된 주된 이유는 무엇인가요?",
            answer: [
                (answerId: 1, answer: "굿즈가 매력있어서"),
                (answerId: 2, answer: "애플 워치 굿즈 받기 위해서"),
                (answerId: 3, answer: "개발 지식을 습득하기 위하여"),
                (answerId: 4, answer: "네트워킹을 위해서")
            ]),
        SurveyData(
            surveyId: 2,
            question: "어떤 계기로 인해 iOS 개발자로 진로를 결정하게 되셨나요?",
            answer: [
                (answerId: 1, answer: "iOS의 ui/ux가 좋아서"),
                (answerId: 2, answer: "내가 아이폰을 사용하고 있기 때문에"),
                (answerId: 3, answer: "iOS의 신기술들이 너무 좋아서"),
                (answerId: 4, answer: "애플 생태계가 좋아서")
            ]),
        SurveyData(
            surveyId: 3,
            question: "평소 관심있는 주제가 무엇인가요?",
            answer: [
                (answerId: 1, answer: "HIG"),
                (answerId: 2, answer: "새 기기 (m2칩, 맥북에어, 14프로 등)"),
                (answerId: 3, answer: "wwdc.. 신기술.. 업데이트 공부"),
                (answerId: 4, answer: "iOS의 컨퍼런스 및 소모임")
            ]),
        SurveyData(
            surveyId: 4,
            question: "개발할 때 제일 싫은 부분은?",
            answer: [
                (answerId: 1, answer: "디자인이 생각보다 안 이쁠 때"),
                (answerId: 2, answer: "다양한 테스트 기기가 없을 때"),
                (answerId: 3, answer: "최소 버전이 낮아서 쓰고 싶은 기술을 사용 못할 때"),
                (answerId: 4, answer: "말이 안통해요 ^^")
            ]),
        SurveyData(
            surveyId: 5,
            question: "내 주변에 있었으면 하는 동료는?",
            answer: [
                (answerId: 1, answer: "디자인을 눈부시게 잘하는 동료"),
                (answerId: 2, answer: "항상 최신 기기를 가지고 있어서 장단점 다 알려주는 동료"),
                (answerId: 3, answer: "WWDC 같이 공부하는 동료"),
                (answerId: 4, answer: "알잘딱깔센하게 알려주는 동료")
            ])
    ]
    
    enum CardCase: String {
        case design = "🎨디자인왕"
        case device = "📱기기왕"
        case newTech = "💻신기술왕"
        case conference = "🙆🏻‍♂️🙆🏻‍♀️소통왕"
        case none
    }
    
    static func getCardCase(answerId: Int) -> CardCase {
        switch answerId {
            case 1:
                return CardCase.design
            case 2:
                return CardCase.device
            case 3:
                return CardCase.newTech
            case 4:
                return CardCase.conference
            default:
                return CardCase.none
        }
    }
    
    static func getQuestionText(surveyId: Int) -> String {
        return TempChartData.questionList.first(where: {$0.surveyId == surveyId})?.question ?? "질문 없음"
    }
    static func getAnswerText(surveyId: Int, answerId: Int) -> String {
        if let surveyData = TempChartData.questionList.first(where: {$0.surveyId == surveyId}),
           let answerText = surveyData.answer.first(where: { $0.answerId == answerId }) {
            return answerText.answer
        } else {
            return "답변 없음"
        }
    }
    
}
