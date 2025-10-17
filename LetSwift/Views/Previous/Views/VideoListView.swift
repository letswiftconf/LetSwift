//
//  VideoListView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI
import BetterSafariView

struct VideoListView: View {
    let filteredItems: [VideoItem]
    let selectedYear: String
    
    @State private var presentURL: URL? = nil
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                ForEach(filteredItems) { item in
                    if #available(iOS 26, *) {
                        Button {
                            presentVideo(item)
                        } label: {
                            VideoListItemView(item: item, presentURL: $presentURL)
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else {
                        NavigationLink(destination: VideoPlayerView(videoID: item.videoID, selectedYear: selectedYear)) {
                            VideoListItemView(item: item, presentURL: $presentURL)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .safariView(item: $presentURL) { item in
            SafariView(url: item, configuration: .init(entersReaderIfAvailable: false, barCollapsingEnabled: true))
                .preferredControlAccentColor(.themePrimary)
                .dismissButtonStyle(.close)
        }
    }
    
    // MARK: - Action
    private func presentVideo(_ item: VideoItem) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(item.videoID)") else { return }
        presentURL = url
    }
}

struct VideoListItemView: View {
    let item: VideoItem
    @Binding var presentURL: URL?
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color(.separator))
            
            Spacer()
            
            HStack(alignment: .center, spacing: 0) {
                AsyncImage(url: URL(string: item.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color(.secondarySystemFill)
                }
                .frame(width: 110, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .padding(.leading, 18)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.vertical, 4)
                        .lineLimit(2)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(item.speaker)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .padding(.trailing, 5)
                        Text(item.timeLine)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.tertiary)
                            .lineLimit(1)
                        Spacer()
                        if item.hasReference {
                            Button {
                                if let url = URL(string: item.referenceLink) {
                                    presentURL = url
                                }
                            } label: {
                                Image(systemName: "rectangle.fill.on.rectangle.angled.fill")
                                    .tint(.secondary)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

#Preview("Previous") {
    PreviousView()
}

#Preview {
    VideoListView(filteredItems: [], selectedYear: "2024")
}
