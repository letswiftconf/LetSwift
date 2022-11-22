//
//  QuestionSessionView.swift
//  LetSwift
//
//  Created by Son on 2022/11/18.
//

import SwiftUI

struct QuestionSessionView: View {
    var session: QuestionSessionData
    init(session: QuestionSessionData) {
        self.session = session
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("관련 세션")
                .font(.bodyBold)
                .foregroundColor(.white)
            HStack(alignment: .top) {
                Image("tempImage")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(session.datetime)
                        .font(.bodyRegular)
                    
                    Spacer().frame(height: 2)
                    
                    Text(session.title)
                        .font(.bodyBold)
                    
                    Spacer().frame(height: 7)
                        
                    Text(session.contents)
                        .font(.subheadRegular)
                    
                    Spacer().frame(height: 21)
                    Button {
                        //TODO : NAVIGATE TO SESSION VIEW
                    } label: {
                        Text("더보기")
                            .font(.bodyRegular)
                    }
                    .frame(width: 100, height: 35, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 17.5)
                            .stroke(.white)
                    )
                    
                    
                }.padding(.horizontal, 30)
            }.padding(.vertical, 18)
        }
    }
}
