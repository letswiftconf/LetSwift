//
//  PreviousView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

struct PreviousView: View {
    @State private var previousViewModel = PreviousViewModel()

    var body: some View {
        NavigationStack {
            VideoListView(sections: previousViewModel.sections)
                .searchable(text: $previousViewModel.searchText,
                            placement: .automatic,
                            prompt: "세션 이름을 검색해보세요")
                .navigationTitle("video.title")
                .navigationSubtitle(previousViewModel.selectedYear)
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        yearFilterMenu
                            .tint(.primary)
                    }
                }
        }
        .task(id: previousViewModel.selectedYear) {
            await previousViewModel.loadVideoData(for: previousViewModel.selectedYear)
        }
    }

    private var yearFilterMenu: some View {
        Menu {
            Picker("video.filter.year", selection: $previousViewModel.selectedYear) {
                ForEach(previousViewModel.years, id: \.self) { year in
                    Text(year).tag(year)
                }
            }
        } label: {
            Label("video.filter", systemImage: "line.3.horizontal.decrease")
        }
    }
}

#Preview {
    PreviousView()
}
