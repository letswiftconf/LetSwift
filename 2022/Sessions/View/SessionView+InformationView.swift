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
        Image.SessionViewTitle
        
        HStack(spacing: 8) {
          Spacer()
          
          Image.Logo.instagram
          
          Image.Logo.twitter
            .padding(.trailing, 17)
        }
        .padding(.top, 20)
        
        Text(self.informationTextString)
          .foregroundColor(.white)
          .font(.bodyRegular)
          .padding(.top, 46)
        
        RowView(
          titleString: "일시",
          contentString: "2022-11-30 | 09:00 - 19:30",
          buttons: [
            GradientButton(textString: "캘린더 추가") {
              print("add calender")
            }
          ]
        )
        .padding(.top, 63)
        
        
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
        .padding(.top, 52)
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
      VStack(alignment: .leading, spacing: 24) {
        HStack(spacing: 9) {
          Text(self.titleString)
            .font(.bodyBold)
            .foregroundColor(.orange)
          
          Spacer()
          
          ForEach(self.buttons) { button in
            button
          }
        }
        
        Text(self.contentString)
          .foregroundColor(.white)
      }
    }
  }
}
