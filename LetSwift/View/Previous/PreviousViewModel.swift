//
//  PreviousViewModel.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

final class PreviousViewModel: ObservableObject {
  @Published var searchText: String = ""
  @Published var videoData: Conference = Conference(year: 2023, items: [])
  @Published var selectedYear: String = "2023"
  
  var years = ["2023", "2022", "2019", "2018", "2017", "2016"]
  
  var filteredItems: [VideoItem] {
    if searchText.isEmpty {
      return videoData.items
    } else {
      return videoData.items.filter { $0.title.contains(searchText) || $0.speaker.contains(searchText) }
    }
  }
  
  func loadVideoData(for year: String) {
    videoData = loadJSON(selectedYear: year)
  }
  
  private func loadJSON(selectedYear: String) -> Conference {
    guard let url = Bundle.main.url(forResource: "playlist-"+selectedYear, withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let videoData = try? JSONDecoder().decode(Conference.self, from: data) else {
      fatalError("Failed to load or parse JSON")
    }
    return videoData
  }
}
