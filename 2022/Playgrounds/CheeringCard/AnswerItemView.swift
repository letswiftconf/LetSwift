//
//  AnswerItem.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct AnswerItemView: View {
    
    // TODO: Userdata POST
    
    var surveyId: Int
    var answerItem: String
    
    init(_ surveyId: Int, _ answerItem: String) {
        self.surveyId = surveyId
        self.answerItem = answerItem
    }
    
    var body: some View {
        NavigationLink {
            if surveyId < TempChartData.questionList.count {
                SurveyView(surveyId: surveyId + 1)
            } else {
                CardView().navigationBarBackButtonHidden(true)
//                LoadingView().navigationBarBackButtonHidden(true)
            }
        } label: {
            HStack {
                Text(answerItem)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .foregroundColor(.black)
                Spacer()
            }
            .background(Color.gray)
            .cornerRadius(8)
        }
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
    }
}

struct AnswerItem_Previews: PreviewProvider {
    static var previews: some View {
        AnswerItemView(0, "")
    }
}
