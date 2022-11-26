//
//  SurveyView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI

struct SurveyView: View {
    
    @State var isActive: Bool = false
    @State var surveyId: Int
    @State var userData: SurveyAnswerModel
    @State private var animationAmount: CGFloat = 1
    
    @Binding var isShowModal: Bool
    @Binding var goToNicknameView: Bool
    
    init(surveyId: Int, userData: SurveyAnswerModel, goToNicknameView:Binding<Bool>, showModal: Binding<Bool>) {
        self.surveyId = surveyId
        self.userData = userData
        self._goToNicknameView = goToNicknameView
        self._isShowModal = showModal
    }
    
    var body: some View {
        VStack {
            VStack {
                if surveyId == 1 {
                    closeButton()
                } else {
                    backCloseButton()
                }
                Spacer()
                Text("\(surveyId) / \(TempChartData.questionList.count)")
                    .font(.bodyBold)
                HStack {
                    Text(TempChartData.getQuestionText(surveyId: surveyId))
                        .font(.title3Bold)
                        .multilineTextAlignment(.center)
                }
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 30, trailing: 30))
                
                ForEach(1..<5) { i in
                    
                    let answerItem = TempChartData.getAnswerText(surveyId: surveyId, answerId: i)
                    
                    Button {
                        if surveyId < TempChartData.questionList.count + 1 {
                            userData.answer.append(AnswerData(surveyId: surveyId, answer: i))
                            surveyId += 1
                            animationAmount += 1
                            
                            if surveyId == TempChartData.questionList.count + 1 {
                                isActive = true
                                saveUserData()
                                putSurveyData(body: userData.answer)
                            } else {
                                isActive = false
                            }
                        }
                    } label: {
                        AnswerItemView(answerItem)
                    }
                    
                    NavigationLink("", isActive: $isActive) {
                        CardView(showModal: $isShowModal)
                            .navigationBarBackButtonHidden(true)
                    }
                }
                Spacer()
            }
            .opacity(Double(animationAmount-1))
            .animation(.easeIn(duration: 0.2),value: animationAmount)
        }
        .onAppear{
            self.animationAmount += 1
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundBlack)
        .navigationTitle("")
    }
}

extension SurveyView {
    
    @ViewBuilder func backCloseButton() -> some View {
        HStack {
            Button {
                animationAmount += 1
                surveyId -= 1
                if surveyId >= 1 {
                    userData.answer.remove(at: surveyId - 1)
                }
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 13, height: 15)
            }
            .padding(20)
            Spacer()
            Button {
                isShowModal = false
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
            }
            .padding(20)
        }
    }
    
    @ViewBuilder func closeButton() -> some View {
        HStack {
            Spacer()
            Button {
                isShowModal = false
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
            }
            .padding(20)
        }
    }
    
    
    private func saveUserData() {
        let category = getCardType(data: userData.answer)
        SharedPreference.shared.cheeringCard = CheeringCardModel(name: userData.name, cardType: category, image: nil)
    }
    
    private func getCardType(data: [AnswerData]) -> String {
        let myCountSet = NSCountedSet()
        var max = 0
        
        for item in data {
            myCountSet.add(item.answer)
        }
        
        for i in 1...data.count {
            if myCountSet.count(for: max) < myCountSet.count(for: i) {
                max = i
            }
        }
        return CardType.cardCase(answerId: max).rawValue
    }
    
    private func putSurveyData(body: [AnswerData]) {
        APICaller.shared.putServeyData(body: body) { result in
            switch result {
            case .success(_):
                print("success")
            case .failure(_):
                print("failure")
            }
        }
    }
}

//struct SurveyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyView(surveyId: 0, userData: AnswerData()
//    }
//}
