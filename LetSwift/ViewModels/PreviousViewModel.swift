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
    var searchText = ""
    /// `nil` shows every year.
    var selectedYear: Int?

    let conferences = VideoCatalog.conferences

    var years: [Int] {
        conferences.map(\.year)
    }

    /// Conferences to show, one section per year, filtered by year and search text.
    var sections: [Conference] {
        let byYear = selectedYear.map { year in conferences.filter { $0.year == year } } ?? conferences
        guard !searchText.isEmpty else { return byYear }
        return byYear.compactMap { conference in
            let videos = conference.videos.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
                || ($0.speaker?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
            return videos.isEmpty ? nil : Conference(year: conference.year, videos: videos)
        }
    }
}
