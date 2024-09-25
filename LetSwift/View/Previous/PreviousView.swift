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
    NavigationView {
      VStack {
        SearchView(searchText: $previousViewModel.searchText)
        
        YearKeywordsView(selectedYear: $previousViewModel.selectedYear, years: previousViewModel.years)
        
        VideoListView(filteredItems: previousViewModel.filteredItems, selectedYear: previousViewModel.selectedYear)
          .onAppear {
            previousViewModel.loadVideoData(for: previousViewModel.selectedYear)
          }
          .onChange(of: previousViewModel.selectedYear) { _, newYear in
            previousViewModel.loadVideoData(for: newYear)
          }
      }
      .background(.black)
    }
    .tabItem {
        Label("previous.title", image: "ic_past")
    }
    .toolbarBackground(.blackBackground, for: .tabBar)
  }
}

#Preview {
  PreviousView()
}
