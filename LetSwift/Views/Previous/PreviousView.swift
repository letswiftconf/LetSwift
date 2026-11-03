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
                .navigationSubtitle(subtitle)
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        yearFilterMenu
                            .tint(.primary)
                    }
                }
        }
    }

    private var subtitle: Text {
        if let year = previousViewModel.selectedYear {
            Text(String(year))
        } else {
            Text("video.filter.all")
        }
    }

    private var yearFilterMenu: some View {
        Menu {
            Picker("video.filter.year", selection: $previousViewModel.selectedYear) {
                Text("video.filter.all").tag(Int?.none)
                ForEach(previousViewModel.years, id: \.self) { year in
                    Text(String(year)).tag(Int?.some(year))
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
