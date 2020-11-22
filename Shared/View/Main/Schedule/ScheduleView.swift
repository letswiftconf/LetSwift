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
                Event()
                Event()
                Event()
                Event()
                Event()
                Text("Add Event To calendar")
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

struct Event: View {
    var body: some View {
        ZStack {
            Placeholder()
            VStack {
                Text("Date")
                Text("Title")
                Text("Description")
            }
        }
        .foregroundColor(.blue)
    }
}
