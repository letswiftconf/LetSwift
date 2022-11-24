//
//  BadgeQuestionView.swift
//  LetSwift
//
//  Created by Son on 2022/11/16.
//

import SwiftUI

struct BadgeQuestionView: View {
    @State var question : QuestionModel
    init(question: QuestionModel) {
        self.question = question
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 32.0) {
            Spacer()
            NavigationLink(destination: QuestionView(data: question)) {
                Text(question.question)
                    .font(.bodyRegular)
                    .foregroundColor(.white)
                    .padding(.all, 20.0)
            }.isDetailLink(false)
            Spacer()
        }
        .background(BackgroundView(isCorrected: question.isCorreted()))
        .padding(.horizontal, 27.0)
    }
    
    
}
