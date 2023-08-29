//
//  SessionView+ScheduleView+RowView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/22.
//

import SwiftUI

extension SessionView.ScheduleView {
    struct RowView: View {
        private let information: SessionInformationModel
        
        init(sessionInformation: SessionInformationModel) {
            self.information = sessionInformation
        }
        
        var body: some View {
          switch ScheduleRowType(rawValue: information.rowTypeString) ?? .normal {
            case .hasDetailView:
                AnyView(
                    HStack(spacing: 30) {
                        VStack {
                            Image("2022_" + (self.information.speaker?.nameString ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .cornerRadius(5)
                            
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(self.information.startTimeString + " - " + self.information.endTimeString)
                                .foregroundColor(.white)
                            
                            Text(self.information.titleString)
                                .font(.bodyBold)
                                .foregroundColor(.white)
                            
                            if self.information.contentString != "" {
                                Text(self.information.contentString)
                                    .font(.subheadRegular)
                                    .foregroundColor(.textGray)
                                    .lineLimit(2)
                            }
                            
                          if self.information.rowTypeString == ScheduleRowType.hasDetailView.rawValue {
                                NavigationLink(
                                    destination: { SessionDetailView(model: self.information) },
                                    label: { self.navigateButtonView }
                                )
                                .padding(.top, 10)
                            }
                        }
                    }
                        .padding(.top, 10)
                )
            case .normal:
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
                    .stroke(Color.backgroundWhite.opacity(0.3), lineWidth: 1)
            )
    }
}
