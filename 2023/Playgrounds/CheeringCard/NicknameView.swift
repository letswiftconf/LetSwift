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
    @State private var isActive = false
    @State private var goToNicknameView = false
    
    @Binding var isShowModal: Bool
    
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
                        checkNameLimitCount(newValue)
                    }
                Rectangle()
                    .frame(width: 300, height: 2)
                    .foregroundColor(.orange)
                Button {
                    hideKeyboard()
                    checkNameNotInput()
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
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("이름을 입력해 주세요."),message: nil, dismissButton:.default(Text("확인")))
                }
                NavigationLink("", isActive: $isActive) {
                    SurveyView(surveyId: 0,
                               userData: answerData(name: name),
                               goToNicknameView: $goToNicknameView,
                               showModal: $isShowModal)
                    .navigationBarBackButtonHidden(true)
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
    private func answerData(name: String) -> SurveyAnswerModel {
        let userData = SurveyAnswerModel(name: name, answer: [], session: "")
        return userData
    }
    
    private func checkNameLimitCount(_ string: String) {
        if string.count > 8 {
            name = subString(string: string, count: 8)
        }
    }
    
    private func checkNameNotInput() {
        if name.count == 0 {
            showingAlert = true
        } else {
            isActive = true
        }
    }
    
    private func subString(string: String, count: Int) -> String {
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

//struct Nickname_Previews: PreviewProvider {
//    static var previews: some View {
//        NicknameView()
//    }
//}
