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
                    self.placeType.buttonView(isClicked: true)
                    
                    Text(self.timeString)
                        .font(.bodyRegular)
                        .foregroundColor(.textGray)
                    
                    Spacer()
                }
                
                Text(self.titleString)
                    .font(.title3Bold)
                    .foregroundColor(.orange)
                
                if self.contentString != "" {
                    Text(self.contentString)
                        .font(.bodyRegular)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
