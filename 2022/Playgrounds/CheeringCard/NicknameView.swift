//
//  Nickname.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct NicknameView: View {
    
    // TODO: Nickname 저장
    
    @State private var name = ""
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text("이름(닉네임)이 무엇인가요?")
                    .font(.title2)
                    .bold()
                TextField("닉네임을 입력해주세요", text: $name)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 50)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .onChange(of: name) { newValue in
                        if newValue.count > 8 {
                            let str: String = newValue
                            let startIndex = str.index(str.startIndex, offsetBy: 0)
                            let endIndex = str.index(str.startIndex, offsetBy: 8)
                            name = String(str[startIndex ..< endIndex])
                        }
                    }
                NavigationLink {
                    SurveyView(surveyId: 1)
                } label: {
                    Text("확인")
                        .font(.title3)
                        .bold()
                        .padding(10)
                        .background(Color.gray)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            }
        }
    }
}

struct Nickname_Previews: PreviewProvider {
    static var previews: some View {
        NicknameView()
    }
}
