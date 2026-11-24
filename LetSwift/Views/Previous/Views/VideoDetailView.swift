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
                // The thumbnail and play glyph are pictures; name the button after what it does,
                // like the row below that does the same.
                .accessibilityLabel("video.detail.watch")
            }

            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text(video.title)
                        .font(.title3.weight(.bold))
                        .accessibilityAddTraits(.isHeader)
                    if let speaker = video.speaker {
                        Label(speaker, systemImage: "person")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            // The person icon says "speaker" to sighted users; say it in words too.
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("video.detail.speaker")
                            .accessibilityValue(speaker)
                    }
                }
                .padding(.vertical, 4)

                LabeledContent("video.detail.event", value: "Let'Swift \(String(year))")
                if let duration = video.duration {
                    LabeledContent("video.detail.time", value: duration)
                        // "20:31" is spoken as a time of day; say "20 minutes, 31 seconds".
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("video.detail.time")
                        .accessibilityValue(video.spokenDuration ?? duration)
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
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(item: video.watchURL, subject: Text(video.title))
                    .tint(.primary)
            }
        }
        .safariView(item: $slidesURL) { url in
            SafariView(url: url, configuration: .init(entersReaderIfAvailable: false, barCollapsingEnabled: true))
                .preferredControlAccentColor(.themePrimary)
                .dismissButtonStyle(.close)
        }
    }
}
