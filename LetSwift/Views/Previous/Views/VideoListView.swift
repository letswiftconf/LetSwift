//
//  VideoListView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

struct VideoListView: View {
    let sections: [Conference]

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
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct VideoListItemView: View {
    let video: Video

    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    /// The narrowest the text may get beside the thumbnail: about seven characters of the title.
    @ScaledMetric(relativeTo: .subheadline) private var minimumTextWidth: CGFloat = 110

    /// Above the default text size, the full title and speaker name show instead of being cut off.
    private var isLargerText: Bool { dynamicTypeSize > .large }

    var body: some View {
        Group {
            if isLargerText {
                // The thumbnail stays beside the text while the text keeps a readable width,
                // and moves above it once it doesn't (accessibility sizes on iPhone).
                ViewThatFits(in: .horizontal) {
                    sideBySide
                    stacked
                }
            } else {
                sideBySide
            }
        }
        .padding(.vertical, 4)
    }

    private var sideBySide: some View {
        HStack(alignment: .top, spacing: 12) {
            VideoThumbnail(video: video, cornerRadius: 8, showsPlayBadge: true)
                .frame(width: 128)

            // The ideal width is what `ViewThatFits` measures; the text still takes all the room there is.
            details
                .frame(idealWidth: minimumTextWidth, alignment: .leading)
        }
    }

    private var stacked: some View {
        VStack(alignment: .leading, spacing: 8) {
            VideoThumbnail(video: video, cornerRadius: 8, showsPlayBadge: true)
                .frame(maxWidth: 360)

            details
        }
    }

    private var details: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(video.title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(isLargerText ? nil : 3)
                .multilineTextAlignment(.leading)

            if let speaker = video.speaker {
                Text(speaker)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(isLargerText ? nil : 1)
                    .multilineTextAlignment(.leading)
            }

            // Duration and slides share a line, or sit one below the other when they don't fit.
            ViewThatFits(in: .horizontal) {
                HStack(spacing: 10) {
                    captionItems
                }
                .lineLimit(1)

                VStack(alignment: .leading, spacing: 2) {
                    captionItems
                }
            }
            .font(.caption2)
            .foregroundStyle(.tertiary)
        }
    }

    @ViewBuilder
    private var captionItems: some View {
        if let duration = video.duration {
            captionItem(Text(duration), systemImage: "clock")
        }
        if video.slides != nil {
            captionItem(Text("video.slides"), systemImage: "doc.text")
        }
    }

    /// Icon + text with tight spacing (Label's default gap is too wide at caption size).
    private func captionItem(_ text: Text, systemImage: String) -> some View {
        HStack(spacing: 3) {
            Image(systemName: systemImage)
                .imageScale(.small)
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
            // The symbols decorate a picture that keeps its size, so they stop growing at the largest standard text size.
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}

#Preview {
    PreviousView()
}
