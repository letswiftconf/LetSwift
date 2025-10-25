//
//  PreviousViewModel.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

@MainActor
@Observable
final class PreviousViewModel {
    var searchText: String = ""
    var videoData: Conference?
    var selectedYear: String
    
    private let sessionProvider = PreviousSessionProvider()
    
    var years: [String] {
        sessionProvider.years
    }
    
    init() {
        let latestYear = sessionProvider.latestSession
        self.selectedYear = latestYear
    }
    
    func fetchInitialData() {
        Task {
            videoData = await sessionProvider.getConference(for: selectedYear)
        }
    }
    
    var filteredItems: [VideoItem] {
        guard let videoData else { return [] }
        if searchText.isEmpty {
            return videoData.items
        } else {
            return videoData.items.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.speaker.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func loadVideoData(for year: String) {
        Task {
            videoData = await sessionProvider.getConference(for: year)
        }
    }
}
