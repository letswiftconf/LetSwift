//
//  QuestionInfoView.swift
//  LetSwift
//
//  Created by Son on 2022/11/18.
//

import SwiftUI

struct QuestionInfoView: View {
    @State var userAnswer: String = ""
    @State var isCorrect: Bool = false
    
    var data: QuestionData
    init(data: QuestionData) {
        self.data = data
        self.isCorrect = data.isCorrect
    }
    
    func checkAnswer() {
        isCorrect = (data.answer == userAnswer)
    }
    
    @ViewBuilder func roundBox() -> some View {
        Rectangle()
            .fill(.white)
            .cornerRadius(5)
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text(data.question)
                .font(.bodyRegular)
                .foregroundColor(.white)
                .padding(.horizontal, 4)
                .padding(.vertical, 16)
            
            HStack(alignment: .top) {
                if #available(iOS 16.0, *) {
                    TextField("답을 입력해주세요", text: $userAnswer, axis: .vertical)
                        .frame(height: 70, alignment: .topLeading)
                        .lineLimit(3)
                        .padding(20)
                } else {
                    TextField("답을 입력해주세요", text: $userAnswer)
                        .frame(height: 70, alignment: .topLeading)
                        .lineLimit(3)
                        .font(.bodyRegular)
                        .padding(20)
                }
            }
            .frame(height: 105)
            .background(roundBox())
            
            Spacer().frame(height: 16)
            
            Button {
                self.checkAnswer()
            } label: {
                Text("답 제출하기")
                    .foregroundColor(.white)
            }
            .frame(height: 51, alignment: .center)
            .frame(maxWidth: .infinity)
            .background(BackgroundView())
        }
        .padding(.horizontal, 5)
    }
}
