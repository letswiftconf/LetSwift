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
                EventView(event: Event(titleImage: "LogoLetter",
                                       title: "SwiftUI vs UIKit",
                                       description: "설명",
                                       date: "11월 22일",
                                       dayOfTheWeek: "수",
                                       time: "19:00 - 21:00")
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
