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
    var conferences: [Conference] = []
    var selectedYear: String

    private let sessionProvider = PreviousSessionProvider()

    var years: [String] {
        sessionProvider.years
    }

    init() {
        self.selectedYear = sessionProvider.latestSession
    }

    /// Conferences to show, one section per year, filtered by the search text.
    var sections: [Conference] {
        guard !searchText.isEmpty else { return conferences }
        return conferences.compactMap { conference in
            let items = conference.items.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.speaker.localizedCaseInsensitiveContains(searchText)
            }
            return items.isEmpty ? nil : Conference(year: conference.year, items: items)
        }
    }

    func loadVideoData(for year: String) async {
        let years = year == PreviousSessionProvider.allYearsKey
            ? Array(self.years.dropFirst())
            : [year]
        var result: [Conference] = []
        for year in years {
            result.append(await sessionProvider.getConference(for: year))
        }
        guard year == selectedYear else { return }
        conferences = result
    }
}
