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
                Group {
                    EventView(event: events[0])
                    EventView(event: events[1])
                    EventView(event: events[2])
                    EventView(event: events[3])
                    EventView(event: events[4])
                }.padding([.all], 8)
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
