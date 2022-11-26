//
//  ScheduleView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(Event.events, id: \.id) { event in
                    EventItemView(event: event)
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("스케줄")
    }
}

// MARK: - Preview
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduleView()
        }
        .previewAsScreen()
    }
}
