//
//  SessionView+InformationView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

private typealias GradientButton = SessionView.GradientButton

extension SessionView {
  struct InformationView: View {
    private let informationTextString: String = """
    지난 3년 간 다채로운 행사와 다양한 만남에 목말라 있었나요?\n
    드디어 긴 침묵 끝에, 3년 만에 2022 레츠스위프트가 오프라인으로 돌아왔습니다!\n
    함께 Swift Playground에서 만나고, 배우고, 즐겨요!
    """
    
    var body: some View {
      VStack(alignment: .leading, spacing: .zero) {
        // FIXME: font
        Text("Let’Swift 2022")
          .font(.largeTitle)
          .foregroundColor(.white)
        
        Text(self.informationTextString)
          .foregroundColor(.white)
          .font(.bodyRegular)
          .padding(.top, 22)
        
        HStack(spacing: 15) {
          Button(
            action: { print("click twitter") },
            label: { Image.Logo.twitter }
          )
          
          Button(
            action: { print("click instagram") },
            label: { Image.Logo.instagram }
          )
          
          Spacer()
        }
        .padding(.top, 28)
        
        RowView(
          titleString: "일시",
          contentString: "2022년 11월30일  09:00 - 19:30",
          buttons: [
            GradientButton(textString: "캘린더 추가") {
              print("add calender")
            }
          ]
        )
        .padding(.top, 46)
        
        RowView(
          titleString: "장소",
          contentString: "서울 서초구 at센터 (창조룸 I,II)",
          buttons: [
            GradientButton(textString: "네이버 지도") {
              print("get naver map")
            },
            GradientButton(textString: "카카오 지도") {
              print("get kakao map")
            }
          ]
        )
        .padding(.top, 20)
      }
    }
  }
}

extension SessionView.InformationView {
  struct RowView: View {
    private let titleString: String
    private let contentString: String
    private let buttons: [GradientButton]
    
    init(titleString: String, contentString: String, buttons: [SessionView.GradientButton]) {
      self.titleString = titleString
      self.contentString = contentString
      self.buttons = buttons
    }
    
    var body: some View {
      VStack(alignment: .leading, spacing: 15) {
        HStack(spacing: 9) {
          Text(self.titleString)
            .font(.bodyBold)
            .foregroundColor(.white)
          
          Spacer()
          
          ForEach(self.buttons) { button in
            button
          }
        }
        
        Text(self.contentString)
          .font(.subheadRegular)
          .foregroundColor(.white)
      }
      .padding(20)
      .background(Color.backgroundCell)
      .cornerRadius(10)
    }
  }
}
