//
//  VideoListView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI
import BetterSafariView

struct VideoListView: View {
    let sections: [Conference]

    @State private var presentURL: URL? = nil

    var body: some View {
        List {
            ForEach(sections, id: \.year) { conference in
                Section(String(conference.year)) {
                    ForEach(conference.items) { item in
                        VideoListItemView(item: item, presentURL: $presentURL)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .safariView(item: $presentURL) { item in
            SafariView(url: item, configuration: .init(entersReaderIfAvailable: false, barCollapsingEnabled: true))
                .preferredControlAccentColor(.themePrimary)
                .dismissButtonStyle(.close)
        }
    }
}

struct VideoListItemView: View {
    let item: VideoItem

    @Binding var presentURL: URL?

    var body: some View {
        HStack(spacing: 12) {
            Button {
                presentURL = URL(string: "https://www.youtube.com/watch?v=\(item.videoID)")
            } label: {
                HStack(spacing: 12) {
                    thumbnailImage
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                            .lineLimit(2)
                        Text([item.speaker, item.timeLine].filter { !$0.isEmpty }.joined(separator: " · "))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                    Spacer(minLength: 0)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.borderless)
            .tint(.primary)

            if item.hasReference {
                Button("발표자료 받기", systemImage: "doc.text") {
                    presentURL = URL(string: item.referenceLink)
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)
            }
        }
    }

    private var thumbnailImage: some View {
        AsyncImage(url: URL(string: item.thumbnail)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color(.systemGray5)
        }
        .frame(width: 85, height: 48)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    PreviousView()
}
