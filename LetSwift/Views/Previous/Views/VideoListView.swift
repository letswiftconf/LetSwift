//
//  VideoListView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

struct VideoListView: View {
    let sections: [Conference]

    @Environment(\.openURL) private var openURL

    var body: some View {
        List {
            ForEach(sections) { conference in
                Section(String(conference.year)) {
                    ForEach(conference.videos) { video in
                        NavigationLink {
                            VideoDetailView(video: video, year: conference.year)
                        } label: {
                            VideoListItemView(video: video)
                        }
                        // VoiceOver: watch straight from the list (swipe up or down on a row).
                        .accessibilityAction(named: Text("video.detail.watch")) {
                            openURL(video.watchURL)
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct VideoListItemView: View {
    let video: Video

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VideoThumbnail(video: video, cornerRadius: 8, showsPlayBadge: true)
                .frame(width: 128)

            VStack(alignment: .leading, spacing: 4) {
                Text(video.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                if let speaker = video.speaker {
                    Text(speaker)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                HStack(spacing: 10) {
                    if let duration = video.duration {
                        // "20:31" is spoken as a time of day; say "20 minutes, 31 seconds".
                        captionItem(
                            Text(duration).accessibilityLabel(video.spokenDuration ?? duration),
                            systemImage: "clock"
                        )
                    }
                    if video.slides != nil {
                        captionItem(
                            Text("video.slides").accessibilityLabel(Text("video.slides.available")),
                            systemImage: "doc.text"
                        )
                    }
                }
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .lineLimit(1)
            }
        }
        .padding(.vertical, 4)
    }

    /// Icon + text with tight spacing (Label's default gap is too wide at caption size).
    private func captionItem(_ text: Text, systemImage: String) -> some View {
        HStack(spacing: 3) {
            Image(systemName: systemImage)
                .imageScale(.small)
                .accessibilityHidden(true)
            text
        }
    }
}

/// 16:9 YouTube-style thumbnail with an optional play badge.
struct VideoThumbnail: View {
    let video: Video
    var cornerRadius: CGFloat = 8
    var showsPlayBadge = false

    var body: some View {
        Color(.systemGray5)
            .aspectRatio(16 / 9, contentMode: .fit)
            .overlay {
                AsyncImage(url: video.thumbnailURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "play.rectangle")
                        .font(.title2)
                        .foregroundStyle(.tertiary)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                if showsPlayBadge {
                    Image(systemName: "play.fill")
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(6)
                        .background(.black.opacity(0.6), in: Circle())
                        .padding(6)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            // Decorative: the title is always shown with it.
            .accessibilityHidden(true)
    }
}

#Preview {
    PreviousView()
}
