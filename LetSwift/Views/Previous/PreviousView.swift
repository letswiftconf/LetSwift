//
//  PreviousView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI
import Accessibility

struct PreviousView: View {
    @State private var previousViewModel = PreviousViewModel()
    @State private var resultAnnouncement: Task<Void, Never>?

    var body: some View {
        NavigationStack {
            VideoListView(sections: previousViewModel.sections)
                .overlay {
                    // A search that matches nothing left a blank list, with nothing to see or for VoiceOver to read.
                    if previousViewModel.sections.isEmpty, !previousViewModel.searchText.isEmpty {
                        ContentUnavailableView.search(text: previousViewModel.searchText)
                    }
                }
                .searchable(text: $previousViewModel.searchText,
                            placement: .automatic,
                            prompt: "세션 이름을 검색해보세요")
                .navigationTitle("video.title")
                .navigationSubtitle(subtitle)
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        yearFilterMenu
                            .tint(.primary)
                    }
                }
        }
        .onChange(of: previousViewModel.searchText) { announceResultCount() }
        .onChange(of: previousViewModel.selectedYear) { announceResultCount() }
    }

    /// The list changes silently while searching or filtering, so tell VoiceOver how many videos are listed.
    /// Waits for a pause in typing, and is spoken after other speech so it doesn't cut off the keyboard echo.
    private func announceResultCount() {
        resultAnnouncement?.cancel()
        resultAnnouncement = Task {
            do { try await Task.sleep(for: .seconds(1)) } catch { return }  // Cancelled by the next change.

            let count = previousViewModel.sections.reduce(0) { $0 + $1.videos.count }
            var announcement = AttributedString(
                count == 0
                ? String(localized: "video.results.none")
                : String(localized: "video.results.count \(count)")
            )
            announcement.accessibilitySpeechAnnouncementPriority = .low
            AccessibilityNotification.Announcement(announcement).post()
        }
    }

    private var subtitle: Text {
        if let year = previousViewModel.selectedYear {
            Text(String(year))
        } else {
            Text("video.filter.all")
        }
    }

    private var yearFilterMenu: some View {
        Menu {
            Picker("video.filter.year", selection: $previousViewModel.selectedYear) {
                Text("video.filter.all").tag(Int?.none)
                ForEach(previousViewModel.years, id: \.self) { year in
                    Text(String(year)).tag(Int?.some(year))
                }
            }
        } label: {
            Label("video.filter", systemImage: "line.3.horizontal.decrease")
        }
        // VoiceOver: "Filter, 2024". The selection is otherwise only in the navigation subtitle.
        .accessibilityValue(subtitle)
    }
}

#Preview {
    PreviousView()
}
