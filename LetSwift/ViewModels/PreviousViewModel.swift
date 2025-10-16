//
//  PreviousViewModel.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

final class PreviousViewModel: ObservableObject {
  @Published var searchText: String = ""
  @Published var videoData: Conference
  @Published var selectedYear: String
  
  private let sessionProvider = PreviousSession()
  
  var years: [String] {
    sessionProvider.years
  }
  
  init() {
    let latestYear = sessionProvider.latestSession
    self.selectedYear = latestYear
    self.videoData = sessionProvider.conference(for: latestYear)
  }
  
  var filteredItems: [VideoItem] {
    if searchText.isEmpty {
      return videoData.items
    } else {
      return videoData.items.filter { $0.title.contains(searchText) || $0.speaker.contains(searchText) }
    }
  }
  
  func loadVideoData(for year: String) {
    videoData = sessionProvider.conference(for: year)
  }
}

