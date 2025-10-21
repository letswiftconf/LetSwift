//
//  PreviousView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

struct PreviousView: View {
    @StateObject private var previousViewModel = PreviousViewModel()
    
    var body: some View {
        NavigationStack {
            if #available(iOS 26, *) {
                mainContent
            } else {
                mainContentPreiOS26
            }
        }
    }
    
    @available(iOS 26, *)
    private var mainContent: some View {
        ScrollView {
            VStack(spacing: 0) {
                YearKeywordsView(selectedYear: $previousViewModel.selectedYear, years: previousViewModel.years)
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
        .background(.background1)
        .navigationTitle("previous.title")
        .toolbarTitleDisplayMode(.inline)
    }
    
    private var mainContentPreiOS26: some View {
        VStack(spacing: 0) {
            SearchView(searchText: $previousViewModel.searchText)
            
            YearKeywordsView(selectedYear: $previousViewModel.selectedYear, years: previousViewModel.years)
            
            VideoListView(filteredItems: previousViewModel.filteredItems, selectedYear: previousViewModel.selectedYear)
                .onAppear {
                    previousViewModel.loadVideoData(for: previousViewModel.selectedYear)
                }
                .onChange(of: previousViewModel.selectedYear) { _, newYear in
                    previousViewModel.loadVideoData(for: newYear)
                }
//                .searchable(text: $previousViewModel.searchText,
//                            placement: .automatic,
//                            prompt: "세션 이름을 검색해보세요")
        }
    }
}

@available(iOS 26, *)
#Preview {
    TabView {
        NavigationStack {
            PreviousView()
        }
    }
}
