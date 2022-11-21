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
          .font(.title3Bold)
          .foregroundColor(.white)
        
        HStack(spacing: 20) {
          ForEach(PlaceType.allCases) { placeType in
            placeType.button(isClicked: placeType == self.clickedPlaceType)
              .onTapGesture {
                self.clickedPlaceType = placeType
              }
          }
          
          Spacer()
        }
        .padding(.top, 25)
        
        Text(self.clickedPlaceType.titleString)
          .font(.bodyBold)
          .foregroundColor(.white)
          .padding(.top, 34)
        
        Text(self.clickedPlaceType.contentString)
          .font(.bodyRegular)
          .foregroundColor(.textGray)
          .padding(.top, 12)
        
        VStack(spacing: 20) {
          ForEach(self.selectedPlaceTypeOfSessionInformations) { information in
            VStack(alignment: .leading, spacing: 20) {
              RowView(sessionInformation: information)
                .padding(.bottom, self.isLastModel(of: information) ? 50 : 0)
              
              if !self.isLastModel(of: information) {
                SessionView.DividerView(height: 1, color: .backgroundWhite)
              }
            }
          }
        }
        .padding(.top, 30)
      }
    }
    
    private var selectedPlaceTypeOfSessionInformations: [SessionInformationModel] {
      let selectedPlaceTypeOfSessionInformation = self.sessionInformations.filter { information in
        information.placeType == self.clickedPlaceType
      }
      return selectedPlaceTypeOfSessionInformation
    }
    
    private func isLastModel(of information: SessionInformationModel) -> Bool {
      return information == self.selectedPlaceTypeOfSessionInformations.last
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
      switch information.rowType {
      case .hasDetailView, .normal:
        AnyView(
          HStack(spacing: 30) {
            VStack {
              self.information.speaker.profileImage
                .resizable()
                .frame(width: 70, height: 70)
              
              Spacer()
            }
            
            VStack(alignment: .leading, spacing: 5) {
              Text(self.information.time.startString + " - " + self.information.time.endString)
                .foregroundColor(.white)
              
              Text(self.information.titleString)
                .foregroundColor(.white)
              
              Text(self.information.contentString)
                .foregroundColor(.textGray)
                .lineLimit(2)
              
              if information.rowType == .hasDetailView {
                NavigationLink(
                  destination: { SessionDetailView() },
                  label: { self.navigateButtonView }
                )
                .padding(.top, 10)
              }
            }
          }
          .padding(.top, 10)
        )
      case .otherTimes:
        AnyView(
          Text(self.information.titleString)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.Gradient.orange)
            .cornerRadius(5)
        )
      }
    }
  }
}

extension SessionView.ScheduleView.RowView {
  private var navigateButtonView: some View {
    Text("더보기")
      .foregroundColor(.white)
      .padding(.vertical, 10)
      .padding(.horizontal, 30)
      .overlay(
        RoundedRectangle(cornerRadius: 50)
          .stroke(Color.backgroundWhite, lineWidth: 1)
      )
  }
}
