//
//  SurveyView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct SurveyView: View {
    
    @State var isActive: Bool = false
    @State var userData: AnswerData
    @State var surveyId: Int
    
    init(surveyId: Int, userData: AnswerData) {
        self.surveyId = surveyId
        self.userData = userData
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
            .padding(.top, 10)
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.bottom, 30)
            ForEach(1..<5) { i in
                let answerItem = TempChartData.getAnswerText(surveyId: surveyId, answerId: i)
                AnswerItemView(answerItem)
                    .onTapGesture {
                        if surveyId < TempChartData.questionList.count {
                            isActive = true
                            userData.answer.append((surveyId: surveyId , answerId: i))
                            surveyId += 1
                        }
                    }
                NavigationLink("", isActive: $isActive) {
                    if surveyId < TempChartData.questionList.count {
                        SurveyView(surveyId: surveyId, userData: userData)
                    } else {
                        // TODO: Userdata POST
                        // TODO: USerdata 저장, Userdefault 값 저장
                        CardView().navigationBarBackButtonHidden(true)
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

//struct SurveyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyView(surveyId: 0, userData: AnswerData()
//    }
//}
