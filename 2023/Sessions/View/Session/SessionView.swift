//
//  SessionView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

struct SessionView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 67) {
                InformationView()
                    .padding(.top, 24)

                ScheduleView()
            }
            .padding(.horizontal, 20)
            .navigationTitle("행사일정")
            .navigationBarHidden(true)
        }
    }
}
