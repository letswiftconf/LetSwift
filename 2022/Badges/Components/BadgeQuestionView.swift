//
//  BadgeQuestionView.swift
//  LetSwift
//
//  Created by Son on 2022/11/16.
//

import SwiftUI

struct BadgeQuestionView: View {
    var question : QuestionData
    init(question: QuestionData) {
        self.question = question
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 32.0) {
            Spacer()
            Text(question.question)
                .font(.bodyRegular)
                .foregroundColor(.white)
                .padding(.all, 20.0)
            Spacer()
        }
        .background(BackgroundView())
        .padding(.horizontal, 27.0)
    }
}
