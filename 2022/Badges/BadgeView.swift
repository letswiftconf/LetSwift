//
//  BadgeView.swift
//  LetSwift
//
//  Created by Son on 2022/11/15.
//

import SwiftUI
import Combine

struct BadgeView: View {
    @State var anyCancellable : [AnyCancellable] = []
    @State var filteredQuestions : [QuestionModel] = []
    @State var questions : [QuestionModel] = []
    @State var filter = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 28.0) {
                    Text("뱃지받지")
                        .font(.title3Bold)
                        .padding(.leading, 39.0)
                    BadgeInfoView(hasBadge: (questions.count - filteredQuestions.count) >= 6)
                    HStack(alignment: .center, spacing: 37.0)  {
                        Text("\(questions.count - filteredQuestions.count) / 6")
                            .frame(width: 60)
                            .font(.bodyRegular)
                        Spacer()
                        Button {
                            self.filter = false
                        } label: {
                            Text("전체 보기")
                                .foregroundColor(.white)
                        }
                        .frame(width: 82, height: 32, alignment: .center)
                        .cornerRadius(5)
                        .background(UnderLineView(isSelected: !filter))
                        
                        Button {
                            self.filter = true
                        } label: {
                            Text("미완료")
                        }
                        .frame(width: 82, height: 32, alignment: .center)
                        .cornerRadius(5)
                        .background(UnderLineView(isSelected: filter))
                    }
                    .padding(.horizontal, 41.0)
                    
                    if self.filter {
                        ForEach(0 ..< filteredQuestions.count, id: \.self) { idx in
                            BadgeQuestionView(question: filteredQuestions[idx])
                        }
                    } else {
                        ForEach(0 ..< questions.count, id: \.self) { idx in
                            BadgeQuestionView(question: questions[idx])
                        }
                    }
                    
                }
                .padding(.horizontal, 20)
            }
            .background(Color.backgroundBlack)
        }.onAppear {
            self.getQuestions()
        }
    }
}


struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
    }
}
