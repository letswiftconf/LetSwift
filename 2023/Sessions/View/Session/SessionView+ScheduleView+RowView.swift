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
          case .hasDetailView, .opening:
                AnyView(
                    HStack(spacing: 30) {
                        VStack {
                            Image(self.information.speaker?.profileString ?? "letSwift2023")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .cornerRadius(5)
                            Spacer()
                        }

                        VStack(alignment: .leading, spacing: .zero) {
                            Text(self.information.startTimeString + " - " + self.information.endTimeString)
                                .font(.footnote)
                                .foregroundColor(.subtext)
                            
                            Text(self.information.titleString)
                                .font(.body1m)
                                .foregroundColor(.title)
                                .padding(.top, 4)

                            if let speakerName = self.information.speaker?.nameString, let teamStatus = self.information.speaker?.isTeam {
                                var teamString: String {
                                    teamStatus == true ? "팀" : "님"
                                }
                                Text("\(speakerName) \(teamString)")
                                    .font(.body3r)
                                    .foregroundColor(.text)
                                    .padding(.top, 8)
                            }

//                            if self.information.rowTypeString == ScheduleRowType.hasDetailView.rawValue {
//                                NavigationLink(
//                                    destination: { SessionDetailView(model: self.information) },
//                                    label: { self.navigateButtonView }
//                                )
//                                .padding(.top, 15)
//                            }
                        }
                    }
                        .padding(.top, 10)
                )
            case .normal:
                AnyView(
                    Text(self.information.titleString)
                        .font(.body3b)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color.primary)
                        .cornerRadius(5)
                        .shadow(color: .primary.opacity(0.5), radius: 2, x: 4, y: 4)
                        .padding(.vertical, 10)
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
            .padding(.horizontal, 33)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.primary.opacity(0.3), lineWidth: 1)
            )
    }
}
