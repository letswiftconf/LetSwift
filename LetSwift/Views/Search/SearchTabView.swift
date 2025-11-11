//
//  SearchTabView.swift
//  LetSwift
//
//  Created by Claude on 11/11/24.
//

import SwiftUI

enum SearchSegment: String, CaseIterable, Identifiable {
    case timetable
    case pastSessions

    var id: String { self.rawValue }

    var title: LocalizedStringKey {
        switch self {
        case .timetable:
            "timetable.title"
        case .pastSessions:
            "previous.title"
        }
    }
}

struct SearchTabView: View {
    @Environment(SessionViewModel.self) var sessionViewModel
    @State private var selectedSegment: SearchSegment = .timetable

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Segment Control
                Picker("", selection: $selectedSegment) {
                    ForEach(SearchSegment.allCases) { segment in
                        Text(segment.title).tag(segment)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                // Content based on selection
                switch selectedSegment {
                case .timetable:
                    SessionView()
                        .environment(sessionViewModel)
                case .pastSessions:
                    PreviousView()
                }
            }
            .navigationTitle("search.title")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let sessionViewModel = SessionViewModel()
    SearchTabView()
        .environment(sessionViewModel)
}
