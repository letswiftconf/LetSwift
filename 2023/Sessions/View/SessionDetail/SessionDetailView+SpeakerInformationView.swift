//
//  SessionDetailView+SpeakerInformationView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/21.
//

import SwiftUI

extension SessionDetailView {
    struct SpeakerInformationView: View {
        private let speakerInformation: SessionInformationModel.SessionSpeakerModel
        
        init(information speakerInformation: SessionInformationModel.SessionSpeakerModel) {
            self.speakerInformation = speakerInformation
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                HStack(spacing: 12) {
                    Image(self.speakerInformation.profileString)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .cornerRadius(5)
//
                    VStack(alignment: .leading, spacing: 6) {
                        Spacer()
                        
                        Text(self.speakerInformation.nameString)
                            .font(.body1m)
                            .foregroundColor(.text)
                        
                        Text(self.speakerInformation.roleString)
                            .font(.body4r)
                            .foregroundColor(.subtext)
                    }
                }
                
                Text(self.speakerInformation.descriptionString)
                    .font(.body4r)
                    .foregroundColor(.text)
            }
        }
    }
}
