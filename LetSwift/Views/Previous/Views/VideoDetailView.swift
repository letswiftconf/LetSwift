//
//  VideoDetailView.swift
//  LetSwift
//

import SwiftUI
import BetterSafariView

struct VideoDetailView: View {
    let item: VideoItem
    let year: Int

    @Environment(\.openURL) private var openURL
    @State private var slidesURL: URL?

    private var videoURL: URL? {
        URL(string: "https://www.youtube.com/watch?v=\(item.videoID)")
    }

    var body: some View {
        List {
            Section {
                Button {
                    if let videoURL { openURL(videoURL) }
                } label: {
                    VideoThumbnail(item: item, cornerRadius: 12)
                        .overlay {
                            Image(systemName: "play.fill")
                                .font(.title)
                                .foregroundStyle(.white)
                                .frame(width: 64, height: 64)
                                .glassEffect(.regular.interactive(), in: Circle())
                        }
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }

            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.title)
                        .font(.title3.weight(.bold))
                    if !item.speaker.isEmpty {
                        Label(item.speaker, systemImage: "person")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)

                LabeledContent("video.detail.event", value: "Let'Swift \(String(year))")
                if !item.timeLine.isEmpty {
                    LabeledContent("video.detail.time", value: item.timeLine)
                }
            }

            Section {
                Button("video.detail.watch", systemImage: "play.rectangle.fill") {
                    if let videoURL { openURL(videoURL) }
                }
                if item.hasReference {
                    Button("video.slides", systemImage: "doc.text") {
                        slidesURL = URL(string: item.referenceLink)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(String(year))
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            if let videoURL {
                ToolbarItem(placement: .topBarTrailing) {
                    ShareLink(item: videoURL, subject: Text(item.title))
                        .tint(.primary)
                }
            }
        }
        .safariView(item: $slidesURL) { url in
            SafariView(url: url, configuration: .init(entersReaderIfAvailable: false, barCollapsingEnabled: true))
                .preferredControlAccentColor(.themePrimary)
                .dismissButtonStyle(.close)
        }
    }
}
