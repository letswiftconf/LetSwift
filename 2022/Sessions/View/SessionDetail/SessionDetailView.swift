//
//  SessionDetailView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/21.
//

import SwiftUI

struct SessionDetailView: View {
  private let model: SessionInformationModel
  
  init(model: SessionInformationModel) {
    self.model = model
  }
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {
        PresentationInformationView(model: self.model)
          .padding(.top, 20)
          .padding(.horizontal, 30)
        
        SessionView.DividerView(height: 5, color: .orange)
        
        SpeakerInformationView(speakerInformation: model.speaker)
          .padding(.bottom, 30)
          .padding(.horizontal, 30)
      }
    }
    .background(Color.backgroundBlack)
    .navigationBarTitleDisplayMode(.inline)
  }
}
