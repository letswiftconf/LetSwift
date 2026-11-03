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
            ForEach(sections, id: \.year) { conference in
                Section(String(conference.year)) {
                    ForEach(conference.items) { item in
                        NavigationLink {
                            VideoDetailView(item: item, year: conference.year)
                        } label: {
                            VideoListItemView(item: item)
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct VideoListItemView: View {
    let item: VideoItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VideoThumbnail(item: item, cornerRadius: 8, showsPlayBadge: true)
                .frame(width: 128)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                if !item.speaker.isEmpty {
                    Text(item.speaker)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                HStack(spacing: 8) {
                    if !item.timeLine.isEmpty {
                        Label(item.timeLine, systemImage: "clock")
                    }
                    if item.hasReference {
                        Label("video.slides", systemImage: "doc.text")
                    }
                }
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .labelStyle(.titleAndIcon)
                .lineLimit(1)
            }
        }
        .padding(.vertical, 4)
    }
}

/// 16:9 YouTube-style thumbnail with an optional play badge.
struct VideoThumbnail: View {
    let item: VideoItem
    var cornerRadius: CGFloat = 8
    var showsPlayBadge = false

    var body: some View {
        Color(.systemGray5)
            .aspectRatio(16 / 9, contentMode: .fit)
            .overlay {
                AsyncImage(url: URL(string: item.thumbnail)) { image in
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
    }
}

#Preview {
    PreviousView()
}
