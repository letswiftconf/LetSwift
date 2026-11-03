//
//  VideoDetailView.swift
//  LetSwift
//

import SwiftUI
import BetterSafariView

struct VideoDetailView: View {
    let video: Video
    let year: Int

    @Environment(\.openURL) private var openURL
    @State private var slidesURL: URL?

    var body: some View {
        List {
            Section {
                Button {
                    openURL(video.watchURL)
                } label: {
                    VideoThumbnail(video: video, cornerRadius: 12)
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
                    Text(video.title)
                        .font(.title3.weight(.bold))
                    if let speaker = video.speaker {
                        Label(speaker, systemImage: "person")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)

                LabeledContent("video.detail.event", value: "Let'Swift \(String(year))")
                if let duration = video.duration {
                    LabeledContent("video.detail.time", value: duration)
                }
            }

            Section {
                Button("video.detail.watch", systemImage: "play.rectangle.fill") {
                    openURL(video.watchURL)
                }
                if let slides = video.slides {
                    Button("video.slides", systemImage: "doc.text") {
                        slidesURL = slides
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
                    ShareLink(item: videoURL, subject: Text(video.title))
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
