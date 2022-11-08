//
//  SessionView+ScheduleView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

private typealias GradientButton = SessionView.GradientButton

extension SessionView {
  struct ScheduleView: View {
    private let sessionInformations: [SessionInformationModel] = SessionInformationModel.dummys
    
    @State
    private var clickedPlaceType: PlaceType = .bigRoom
    
    var body: some View {
      VStack(alignment: .leading, spacing: .zero) {
        Text("Schedule")
//          .font(.inter)
          .foregroundColor(.orange)
        
        HStack(spacing: 20) {
          ForEach(PlaceType.allCases) { placeType in
            placeType.button(isClicked: placeType == self.clickedPlaceType)
              .onTapGesture {
                self.clickedPlaceType = placeType
              }
          }
          
          Spacer()
        }
        .padding(.top, 38)
        
        Text(self.clickedPlaceType.titleString)
          .font(.bodyBold)
          .foregroundColor(.white)
          .padding(.top, 34)
        
        Text(self.clickedPlaceType.contentString)
          .font(.bodyRegular)
          .foregroundColor(.textGray)
          .padding(.top, 12)
        
        VStack(spacing: 20) {
          ForEach(self.sessionInformations) { information in
            if information.placeType == self.clickedPlaceType {
              RowView(sessionInformation: information)
            }
          }
        }
        .padding(.top, 30)
      }
    }
  }
}

extension SessionView.ScheduleView {
  struct RowView: View {
    private let information: SessionInformationModel
    
    init(sessionInformation: SessionInformationModel) {
      self.information = sessionInformation
    }
    
    var body: some View {
      HStack(spacing: 16) {
        Text(self.information.time.startString)
          .foregroundColor(.white)
        
        self.information.speaker.profileImage
          .resizable()
          .frame(width: 70, height: 70)
        
        VStack(alignment: .leading, spacing: 4) {
          Text(self.information.titleString)
            .foregroundColor(.white)
          
          Text(self.information.contentString)
            .foregroundColor(.textGray)
            .lineLimit(2)
          
          HStack {
            Spacer()
            
            GradientButton(textString: "더보기", action: { print("navigate to DetailSessionView") })
          }
          
          SessionView.DividerView(height: 1)
        }
      }
    }
  }
}
