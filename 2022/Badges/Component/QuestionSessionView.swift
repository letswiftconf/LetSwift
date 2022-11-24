//
//  QuestionSessionView.swift
//  LetSwift
//
//  Created by Son on 2022/11/18.
//

import SwiftUI

struct QuestionSessionView: View {
    var model: QuestionModel
    
    init(model: QuestionModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("관련 세션")
                .font(.bodyBold)
                .foregroundColor(.white)
            HStack(alignment: .top) {
                Image("2022_\(model.speakerRes.name)")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(model.sessionRes.getTime())
                        .font(.bodyRegular)
                    
                    Spacer().frame(height: 2)
                    
                    Text(model.sessionRes.title)
                        .font(.bodyBold)
                    
                    Spacer().frame(height: 7)
                        
                    Text(model.sessionRes.content)
                        .font(.subheadRegular)
                    
                    Spacer().frame(height: 21)
                    NavigationLink(destination: SessionDetailView(model: model.toSessionInfomation())) {
                        Text("더보기")
                            .foregroundColor(Color.orange)
                            .font(.bodyRegular)
                    }
                    .frame(width: 100, height: 35, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 17.5)
                            .stroke(Color.orange)
                    )
                    
                    
                }.padding(.horizontal, 30)
            }.padding(.vertical, 18)
        }
    }
}
