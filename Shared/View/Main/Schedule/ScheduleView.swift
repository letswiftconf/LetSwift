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
                EventView(
                    titleImageName: "dummy",
                    title: "SwiftUI vs UIKit",
                    description: "description",
                    date: "2020-11-30"
                )
                    .padding([.leading, .trailing], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
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
