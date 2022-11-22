//
//  BadgeView.swift
//  LetSwift
//
//  Created by Son on 2022/11/15.
//

import SwiftUI

struct BadgeView: View {
    var questions = QuestionData.dummy
    @State var filter = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 28.0) {
                    Text("뱃지받지")
                        .font(.title3Bold)
                        .padding(.leading, 39.0)
                    BadgeInfoView()
                    HStack(alignment: .center, spacing: 37.0)  {
                        Text("0 / 6")
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
                        .background(BackgroundView())
                        
                        Button {
                            self.filter = true
                        } label: {
                            Text("미완료")
                        }
                        .frame(width: 82, height: 32, alignment: .center)
                        .cornerRadius(5)
                        .background(UnderLineView())
                    }
                    .padding(.horizontal, 41.0)
                    ForEach(0 ..< questions.count, id: \.self) { idx in
                        BadgeQuestionView(question: questions[idx])
                    }
                }
            }
        }
    }
}




struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
    }
}
