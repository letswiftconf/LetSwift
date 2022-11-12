//
//  Nickname.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct NicknameView: View {
    
    @State private var name = ""
    @State private var showingAlert = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text("이름(닉네임)이\n무엇인가요?")
                    .font(.title3Bold)
                    .multilineTextAlignment(.center)
                TextField("", text: $name)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .onChange(of: name) { newValue in
                        checkNameCount(newValue)
                    }
                Rectangle()
                    .frame(width: 300, height: 2)
                    .foregroundColor(.orange)
                // TODO: - 닉네임 입력 확인 필요
                if (name.count != 0){
                    NavigationLink {
                        SurveyView(surveyId: 1,userData: answerData(name: name) )
                    } label: {
                        HStack {
                            Text("확인")
                                .font(.title3)
                                .padding(10)
                                .foregroundColor(.white)
                        }
                        .frame(width: 150, height: 40)
                        .background(gradationBox())
                        .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundBlack)
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

extension NicknameView {
    func answerData(name: String) -> AnswerData {
        let userData = AnswerData(name: name, answer: [])
        return userData
    }
    

    func checkNameCount(_ string: String){
        if string.count > 8 {
            name = subString(string: string, count: 8)
        }
    }
    
    func checkname() {
        if name.count == 0 {
            showingAlert = true
        }
    }
    
    func subString(string: String, count: Int) -> String {
        let startIndex = string.index(string.startIndex, offsetBy: 0)
        let endIndex = string.index(string.startIndex, offsetBy: count)
        return String(string[startIndex ..< endIndex])
    }
    
    
    @ViewBuilder func gradationBox() -> some View {
        Rectangle()
            .fill(LinearGradient.gradientOrange.opacity(0.45))
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
    }
}

struct Nickname_Previews: PreviewProvider {
    static var previews: some View {
        NicknameView()
    }
}
