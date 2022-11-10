//
//  SurveyView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct SurveyView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var surveyId: Int
    
    init(surveyId: Int) {
        self.surveyId = surveyId
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(TempChartData.getQuestionText(surveyId: surveyId))
                    .font(.title)
                    .bold()
            }
            ForEach(1..<5) { i in
                let answerItem = TempChartData.getAnswerText(surveyId: surveyId, answerId: i)
                AnswerItemView(surveyId, answerItem)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
        }
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView(surveyId: 0)
    }
}
