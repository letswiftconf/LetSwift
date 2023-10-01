//
//  AnswerItem.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct AnswerItemView: View {
    
    var answerItem: String
    
    init(_ answerItem: String) {
        self.answerItem = answerItem
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Text(answerItem)
                .font(.subheadRegular)
                .multilineTextAlignment(.center)
                .padding(15)
                .tint(.white)
            
            Spacer()
        }
        .background(Color.primary)
        .cornerRadius(5)
        .shadow(color: .primary.opacity(0.5), radius: 2, x: 4, y: 4)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
    }
}

extension AnswerItemView {
    @ViewBuilder func gradationBox() -> some View {
        Rectangle()
            .fill(LinearGradient.gradientOrange.opacity(0.45))
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
    }
    
    @ViewBuilder func boxText(title: String) -> some View {
        HStack(alignment: .center) {
            Text("?")
                .font(.bodyRegular)
                .frame(width: 40, height: 55)
                .background(Color.white)
                .cornerRadius(3)
                .foregroundColor(.black)
            Text(title)
                .padding(.leading, 20)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .font(.bodyBold)
            Spacer()
            Image("chevron")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .frame(height: 90)
        .background(gradationBox())
    }
}


//struct AnswerItem_Previews: PreviewProvider {
//    static var previews: some View {
//        AnswerItemView(0, "")
//    }
//}
