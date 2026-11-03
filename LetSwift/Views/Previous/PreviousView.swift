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
            mainContent
        }
        // Ensure initial async setup happens once when the view appears
        .onAppear {
            previousViewModel.fetchInitialData()
        }
    }

    private var mainContent: some View {
        ScrollView {
            VStack(spacing: 0) {
                VideoListView(filteredItems: previousViewModel.filteredItems, selectedYear: previousViewModel.selectedYear)
                    .onAppear {
                        previousViewModel.loadVideoData(for: previousViewModel.selectedYear)
                    }
                    .onChange(of: previousViewModel.selectedYear) { _, newYear in
                        previousViewModel.loadVideoData(for: newYear)
                    }
                    .scrollDisabled(true)
                    .searchable(text: $previousViewModel.searchText,
                                placement: .automatic,
                                prompt: "세션 이름을 검색해보세요")
            }
        }
        .navigationTitle("video.title")
        .navigationSubtitle(previousViewModel.selectedYear)
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                yearFilterMenu
            }
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
    TabView {
        NavigationStack {
            PreviousView()
        }
    }
}

