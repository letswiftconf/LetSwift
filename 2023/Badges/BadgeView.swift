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
    @State var correctedCount = 0
    @State var filter = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 28.0) {
                    Text("뱃지받지")
                        .font(.title3Bold)
                        .padding(.leading, 39.0)
                    HStack(alignment: .center, spacing: 14.0) {
                        Image(correctedCount >= 6 ? "badge-image" : "badge-none")
                            .resizable()
                            .cornerRadius(12)
                            .frame(width: 132.0, height: 132.0)
                            
                        Text(correctedCount >= 6 ? "🎉🎉🎉🎉\nLet's play at\nSwift Playgrounds" : "세션에 참여한 후, 아래 문제를 풀어보세요 !")
                            .truncationMode(.tail)
                            .font(.bodyRegular)
                            .padding(.horizontal, 31.0)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 35.0)
                    HStack(alignment: .center, spacing: 37.0)  {
                        Text("\(correctedCount) / 6")
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
                .onAppear {
                    self.getQuestions()
                }
                .padding(.horizontal, 20)
            }
            .background(Color.backgroundBlack)
        }
    }
}


struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
    }
}
