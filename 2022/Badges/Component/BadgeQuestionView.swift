//
//  BadgeQuestionView.swift
//  LetSwift
//
//  Created by Son on 2022/11/16.
//

import SwiftUI

struct BadgeQuestionView: View {
    
    var question : QuestionModel
    
    init(question: QuestionModel) {
        self.question = question
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 32.0) {
            Spacer()
            NavigationLink(destination: QuestionView(data: question, isCorrected: isCorreted())) {
                Text(question.question)
                    .font(.bodyRegular)
                    .foregroundColor(.white)
                    .padding(.all, 20.0)
            }
            Spacer()
        }
        .background(BackgroundView(isCorrected: isCorreted()))
        .padding(.horizontal, 27.0)
    }
    
    func isCorreted() -> Bool {
        return SharedPreference().getObjectValues(key: "question_\(question.id)") as? Bool ?? false
    }
}
