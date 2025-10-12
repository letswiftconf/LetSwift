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
                previousViewModel.loadVideoData(for: newYear)
              }
              .searchable(text: $previousViewModel.searchText,
                          placement: .automatic,
                          prompt: "세션 이름을 검색해보세요")
          }
          .background(.darkBackground)
      }
      
  }
}

#Preview {
  PreviousView()
}
