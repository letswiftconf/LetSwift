//
//  SurveyView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct SurveyView: View {
    
    @State var isActive: Bool = false
    
    @State var surveyId: Int
    @State var userData: SurveyAnswerModel
    
    @Binding var isShowModal: Bool
    
    init(surveyId: Int, userData: SurveyAnswerModel, showModal: Binding<Bool>) {
        self.surveyId = surveyId
        self.userData = userData
        self._isShowModal = showModal
    }
    
    // TODO: view 먼저 바뀌는 문제 해결
    var body: some View {
        VStack {
            Text("\(surveyId) / \(TempChartData.questionList.count - 1)")
                .font(.bodyBold)
            HStack {
                Text(TempChartData.getQuestionText(surveyId: surveyId))
                    .font(.title3Bold)
                    .multilineTextAlignment(.center)
            }
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 30, trailing: 30))
            
            ForEach(1..<5) { i in
                let answerItem = TempChartData.getAnswerText(surveyId: surveyId, answerId: i)
                Button {
                    if surveyId < TempChartData.questionList.count {
                        userData.answer.append(AnswerData(surveyId: surveyId, answerId: i))
                        surveyId += 1
                        isActive = true
                    }
                    if isActive == true && surveyId == TempChartData.questionList.count {
                        saveUserData()
                    }
                } label: {
                    AnswerItemView(answerItem)
                }
                NavigationLink("", isActive: $isActive) {
                    if surveyId < TempChartData.questionList.count {
                        SurveyView(surveyId: surveyId,
                                   userData: userData,
                                   showModal: $isShowModal
                        )
                    } else {
                        // TODO: Userdata POST - X
                        CardView(showModal: $isShowModal)
                            .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundBlack)
        .navigationTitle("")
        // TODO: - 뒤로가기 시 데이터 새로 저장
    }
}

extension SurveyView {
    
    private func saveUserData() {
        let category = getCatetory(data: userData.answer)
        SharedPreference.shared.cheeringCard = CheeringCardModel(name: userData.name, category: category, image: "")
    }
    
    private func getCatetory(data: [AnswerData]) -> String {
        let myCountSet = NSCountedSet()
        var max = 0
        
        for item in data {
            myCountSet.add(item.answerId)
        }
        
        for i in 1...data.count {
            if myCountSet.count(for: max) < myCountSet.count(for: i) {
                max = i
            }
        }
        return cardCase(answerId: max).rawValue
    }
    
    enum CardCase: String {
        case design = "🎨디자인왕"
        case device = "📱기기왕"
        case newTech = "💻신기술왕"
        case conference = "🙆🏻‍♂️🙆🏻‍♀️소통왕"
        case none
    }
    
    private func cardCase(answerId: Int) -> CardCase {
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
    
}

//struct SurveyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyView(surveyId: 0, userData: AnswerData()
//    }
//}
