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
                    VStack {
                        EventView(event: events[0])
                            .padding([.all], 8)
                        EventView(event: events[1])
                            .padding([.all], 8)
                        EventView(event: events[2])
                            .padding([.all], 8)
                        EventView(event: events[3])
                            .padding([.all], 8)
                        EventView(event: events[4])
                            .padding([.all], 8)
                        Text("Schedule")
                            .navigationTitle("Schedule")
                    }
                }
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
