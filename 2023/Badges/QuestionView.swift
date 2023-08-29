//
//  QuestionView.swift
//  LetSwift
//
//  Created by Son on 2022/11/18.
//

import SwiftUI

struct QuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    var data: QuestionModel
    var isCorrected : Bool
    
    @State var isCorrect = false
    
    init(data: QuestionModel) {
        self.data = data
        self.isCorrected = data.isCorreted()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("X")
            }
            .padding(.horizontal, 29.0)
            
            Text("Q.")
                .font(.title3Bold)
                .padding(.horizontal, 28.0)
                .padding(.top, 19.0)
            QuestionInfoView(data: data)
            Spacer()
                .frame(height: 53.0)
            QuestionSessionView(model: data)
            Spacer()
        }
        .background(Color.backgroundBlack)
        .navigationBarBackButtonHidden(true)
        
    }
}

//
//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView(data: QuestionModel.dummy.first!)
//    }
//}
