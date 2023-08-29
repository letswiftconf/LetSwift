//
//  QuestionInfoView.swift
//  LetSwift
//
//  Created by Son on 2022/11/18.
//

import SwiftUI

struct QuestionInfoView: View {
    @State var userAnswer: String = ""
    @State var isIncorrect: Bool = false
    @State var isCorrected: Bool
    let data: QuestionModel
    init(data: QuestionModel) {
        self.data = data
        self.isCorrected = data.isCorreted()
    }
    
    func checkAnswer() {
        isIncorrect = (data.answer != userAnswer)
        
        if !isIncorrect {
            isCorrected = true
            UserDefaults.standard.set(isCorrected, forKey: "question_\(data.id)")
            UserDefaults.standard.synchronize()
        }
    }
    
    @ViewBuilder func roundBox() -> some View {
        Rectangle()
            .fill(Color.backgroundCell)
            .cornerRadius(5)
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text(data.question)
                .font(.bodyRegular)
                .padding(.horizontal, 4)
                .padding(.vertical, 16)
            
            HStack(alignment: .top) {
                if #available(iOS 16.0, *) {
                    TextField(isCorrected ? self.data.answer : "답을 입력해주세요", text: $userAnswer, axis: .vertical)
                        .disabled(isCorrected)
                        .frame(height: 70, alignment: .topLeading)
                        .foregroundColor(.orange)
                        .lineLimit(3)
                        .padding(20)
                } else {
                    TextField(isCorrected ? self.data.answer : "답을 입력해주세요", text: $userAnswer)
                        .frame(height: 70, alignment: .topLeading)
                        .disabled(isCorrected)
                        .lineLimit(3)
                        .font(.bodyRegular)
                        .foregroundColor(.orange)
                        .padding(20)
                }
            }
            .frame(height: 105)
            .background(roundBox())
            
            Spacer().frame(height: 16)
            
            Button {
                self.checkAnswer()
            } label: {
                Text(isCorrected ? "🎉정답입니다🎉" :
                        isIncorrect ? "오답입니다" : "답 제출하기")
                    .font(isIncorrect || isCorrected ? .bodyBold : .bodyRegular)
                    .foregroundColor(.white)
            }
            .disabled(isCorrected)
            .frame(height: 51, alignment: .center)
            .frame(maxWidth: .infinity)
            .background(BackgroundView(isCorrected: true))
        }
        .padding(.horizontal, 24)
    }
}
