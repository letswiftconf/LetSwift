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
                    .padding(.top, 40)
                    .padding(.bottom, 60)
                    .padding(.horizontal, 20)
                
                DividerView(height: 5, color: .orange)
                
                ScheduleView()
                    .padding(.top, 41)
                    .padding(.horizontal, 20)
            }
            .navigationTitle("행사일정")
            .navigationBarHidden(true)
        }
        .background(Color.backgroundBlack)
    }
}
