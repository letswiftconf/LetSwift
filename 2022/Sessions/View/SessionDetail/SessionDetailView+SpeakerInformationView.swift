//
//  SessionDetailView+SpeakerInformationView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/21.
//

import SwiftUI

extension SessionDetailView {
    struct SpeakerInformationView: View {
        private let speakerInformation: SessionInformationModel.Speaker
        
        init(speakerInformation: SessionInformationModel.Speaker) {
            self.speakerInformation = speakerInformation
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                HStack(spacing: 12) {
                    self.speakerInformation.profileImage
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(self.speakerInformation.nameString)
                            .font(.bodyRegular)
                            .foregroundColor(.orange)
                        
                        Text(self.speakerInformation.companyString)
                            .font(.caption2Regular)
                            .foregroundColor(.textGray)
                    }
                }
                
                Text(self.speakerInformation.introductionString)
                    .font(.bodyRegular)
                    .foregroundColor(.white)
            }
        }
    }
}
