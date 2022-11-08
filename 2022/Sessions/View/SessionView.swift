//
//  SessionView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

struct SessionView: View {
  var body: some View {
    ScrollView {
      VStack(spacing: .zero) {
        InformationView()
          .padding(.top, 20)
          .padding(.bottom, 66)
          .padding(.horizontal, 20)
        
        DividerView(height: 5)
        
        ScheduleView()
          .padding(.top, 41)
          .padding(.horizontal, 20)
      }
    }
    .background(Color.backgroundBlack)
  }
}
