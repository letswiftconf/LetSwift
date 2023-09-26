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
    var answer: [(answerId: Int?, answer: String)]
}
// TODO: 설문, 답변 텍스트 변경 필요
struct TempChartData {
    static let questionList = [
        SurveyData(
            surveyId: 0,
            question: "Let’Swift 2022 컨퍼런스에 참여하게 된 주된 이유는 무엇인가요?",
            answer: [
                (answerId: 1, answer: "Let’Swift 2022 캐릭터, Swity 너무 귀여워요"),
                (answerId: 2, answer: "굿즈는 못참아! 나는야 굿즈 콜렉터!"),
                (answerId: 3, answer: "눈부신 세션들 빨리 듣고싶어요"),
                (answerId: 4, answer: "iOS개발자들과 소통하고싶어요")
            ]),
        SurveyData(
            surveyId: 1,
            question: "어떤 계기로 인해 iOS 개발자로 진로를 결정하게 되셨나요?",
            answer: [
                (answerId: 1, answer: "iOS의 UI/UX가 좋아서"),
                (answerId: 2, answer: "내가 아이폰을 사용하고 있기 때문에"),
                (answerId: 3, answer: "iOS의 신기술들이 너무 좋아서"),
                (answerId: 4, answer: "애플 생태계가 좋아서")
            ]),
        SurveyData(
            surveyId: 2,
            question: "평소 관심있는 주제가 무엇인가요?",
            answer: [
                (answerId: 1, answer: "애플 감성의 디자인 가이드"),
                (answerId: 2, answer: "트렌드를 이끌어 가는 애플 기기"),
                (answerId: 3, answer: "매년 WWDC에서 발표되는 신기술"),
                (answerId: 4, answer: "다양한 배움의 기회가 있는 iOS 컨퍼런스")
            ]),
        SurveyData(
            surveyId: 3,
            question: "개발할 때 제일 힘들었던 경험은 무엇인가요?",
            answer: [
                (answerId: 1, answer: "HIG을 고려하지 않은 디자인을 받았을 때"),
                (answerId: 2, answer: "다양한 테스트 기기가 없을 때"),
                (answerId: 3, answer: "최소 버전이 낮아서 쓰고 싶은 기술을 사용 못할 때"),
                (answerId: 4, answer: "동료와 의사소통이 힘들 때")
            ]),
        SurveyData(
            surveyId: 4,
            question: "내 주변에 있었으면 좋겠는 동료는 누구인가요?",
            answer: [
                (answerId: 1, answer: "HIG를 고려해 디자인을 해주는 동료"),
                (answerId: 2, answer: "애플 기기마다 장단점을 다 알려주는 동료"),
                (answerId: 3, answer: "WWDC 같이 공부하는 동료"),
                (answerId: 4, answer: "알잘딱깔센한 동료")
            ]),
        SurveyData(
            surveyId: 5,
            question: "Let’Swift 2023 컨퍼런스에서 제일 관심있는 세션은 무엇인가요??",
            answer: [
                (answerId: 1, answer: "스위프트 매크로, 어디다 쓰죠?"),
                (answerId: 2, answer: "iOS 애플리케이션 개발 생산성 고찰"),
                (answerId: 3, answer: "객체가 함수를 만났을 때"),
                (answerId: 4, answer: "SwiftUI를 통한 일과 놀이에 관한 이야기"),
                (answerId: 5, answer: "오픈 소스로서의 Swift 깊게 바라보기"),
                (answerId: 6, answer: "Tuist, 도입은 했는데 그래서 Modular Architecture은 어떻게 만들어가면 되나요?"),
                (answerId: 7, answer: "요즘 유행하는 AI 나도 해보자 (feat. CoreML)"),
                (answerId: 8, answer: "잊지마세요 Unwind Segue - 생각보다 Segue는 \"여전히\" 유용합니다."),
                (answerId: 9, answer: "Xcode 프로젝트와 컴파일러 인덱스로 의존성 찾기"),
                (answerId: 10, answer: "SwiftUI 레이아웃과 데이터 플로우 이해하기"),
                (answerId: 11, answer: "SwiftUI border 어디까지 그려보셨나요?"),
                (answerId: 12, answer: "Metal Shader로 달라지는 UX/UI의 변화"),
                (answerId: 13, answer: "Swift로 Cross Platform 하기"),
                (answerId: 14, answer: "CoreBluetooth로 BLE기기를 연동할 때 마주하는 문제들과 부딪혀보기"),
                (answerId: 15, answer: "Path of Swift - Swift가 프로그램이 되기까지")
            ])
    ]
    
    enum CardCase: String {
        case design = "디자인에 진심"
        case device = "애플 기기에 진심"
        case newTech = "신기술에 진심"
        case conference = "소통에 진심"
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
        if let surveyData = TempChartData.questionList.first(where: {$0.surveyId == surveyId})
            {
            let answerText = surveyData.answer[answerId].answer
            
            return answerText
        } else {
            return "답변 없음"
        }
    }
}
