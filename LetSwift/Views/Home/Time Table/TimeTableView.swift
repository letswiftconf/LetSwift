//
//  TimeTableView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct TimeTableView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("timetable.title")
                .font(.headline)
            RoundedRectangle(cornerRadius: 23, style: .continuous)
                .foregroundStyle(Color(.systemGroupedBackground))
                .frame(height: 640)
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            TimeTableView()
        }
        .padding(.horizontal)
    }
}
