//
//  CardView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/08.
//

import SwiftUI



struct CardView: View {
    
    // TODO: Loading, 이미지 저장, 공유 기능
    // TODO: 다시뽑기, Userdefault 값 저장
    
    @Environment(\.presentationMode) var presentationMode
    
    let category = TempChartData.getCardCase(answerId: 1)
    let name = "허지인"
    
    var body: some View {
        VStack {
            Image("CheeringCard")
            Text("\(category.rawValue) \(name)님! \n Playground에서 함께 놀아요")
                .font(.title2)
                .bold()
                .foregroundColor(Color.white)
            Text("#letswift #렛츠스위프트 @letswift를 태그해서 \n이미지를 공유하면 추첨해서 굿즈를 드립니다. ")
                .font(.caption)
                .bold()
                .foregroundColor(Color.gray)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            NavigationLink {
                SurveyView(surveyId: 1)
            } label: {
                Text("참가자 전체 결과 보기")
                    .font(.title3)
                    .bold()
            }
            .padding(10)
            .background(Color.gray)
            .foregroundColor(.black)
            .cornerRadius(8)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                NavigationLink {
                    SurveyView(surveyId: 1)
                } label: {
                    Text("이미지 저장")
                        .font(.system(size: 15))
                        .padding(10)
                        .background(Color.gray)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                NavigationLink {
                    SurveyView(surveyId: 1)
                } label: {
                    Text("카드 공유")
                        .font(.system(size: 15))
                        .padding(10)
                        .background(Color.gray)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                NavigationLink {
                    SurveyView(surveyId: 1)
                } label: {
                    Text("동료 찾기")
                        .font(.system(size: 15))
                        .padding(10)
                        .background(Color.gray)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
            
            //TODO: Add Retry Button
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
