//
//  QuestionView.swift
//  LetSwift
//
//  Created by Son on 2022/11/18.
//

import SwiftUI

struct QuestionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var data: QuestionData
    init(data: QuestionData) {
        self.data = data
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("X")
            }
            Text("Q.")
                .font(.title3Bold)
                
                .padding(.horizontal, 9.0)
                .padding(.top, 19.0)
            QuestionInfoView(data: data)
            Spacer()
                .frame(height: 53.0)
            QuestionSessionView(session: data.session)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 29.0)

    }
}


struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(data: QuestionData.dummy.first!)
    }
}
