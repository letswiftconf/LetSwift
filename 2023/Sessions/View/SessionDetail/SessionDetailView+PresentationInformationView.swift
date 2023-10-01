//
//  SessionDetailView+PresentationInformationView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/21.
//

import SwiftUI

extension SessionDetailView {
    struct PresentationInformationView: View {
        private let placeType: PlaceType
        private let timeString: String
        private let titleString: String
        private let contentString: String
        
        init(model: SessionInformationModel) {
            self.placeType = PlaceType(rawValue: model.placeTypeString) ?? .bigRoom
            self.timeString = model.startTimeString + " ~ " + model.endTimeString
            self.titleString = model.titleString
            self.contentString = model.contentString
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                HStack(spacing: 20) {
                    Text(placeType.textString)
                        .font(.body3m)
                        .foregroundColor(.title)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 7)
                        .background(Color.primary)
                        .cornerRadius(5)
                        .shadow(color: .primary.opacity(0.5), radius: 2, x: 4, y: 4)

                    Text(self.timeString)
                        .font(.body4r)
                        .foregroundColor(.subtext)
                    
                    Spacer()
                }
                
                Text(self.titleString)
                    .font(.title3Bold)
                    .foregroundColor(.title)
                
                if self.contentString != "" {
                    Text(self.contentString)
                        .font(.bodyRegular)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
