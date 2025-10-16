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
          VStack(spacing: 0) {
//            SearchView(searchText: $previousViewModel.searchText)
            
            YearKeywordsView(selectedYear: $previousViewModel.selectedYear, years: previousViewModel.years)
            
            VideoListView(filteredItems: previousViewModel.filteredItems, selectedYear: previousViewModel.selectedYear)
              .onAppear {
                previousViewModel.loadVideoData(for: previousViewModel.selectedYear)
              }
              .onChange(of: previousViewModel.selectedYear) { _, newYear in
                previousViewModel.searchText = ""
                previousViewModel.loadVideoData(for: newYear)
              }
              .searchable(text: $previousViewModel.searchText,
                          placement: .automatic,
                          prompt: "\(previousViewModel.selectedYear)년 세션 검색")
          }
      }
      
  }
}

#Preview {
  PreviousView()
}
