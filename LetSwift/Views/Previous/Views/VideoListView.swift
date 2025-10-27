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
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 10) {
                    thumbnailImage
                        .padding(.leading, 14)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.title)
                            .font(.system(size: 14, weight: .regular))
                            .lineLimit(2)
                        
                        Spacer()
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            if (!item.speaker.isEmpty) {
                                Text(item.speaker)
                                    .font(.system(size: 10, weight: .regular))
                                    .foregroundStyle(Color(.systemGray))
                                    .lineLimit(1)
                            }
                            Text(item.timeLine)
                                .font(.system(size: 10, weight: .regular))
                                .foregroundStyle(Color(.systemGray))
                                .lineLimit(1)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.bottom, 6)
                
                Divider()
                    .frame(height: 2)
                    .background(Color(.systemGray2))
                    .padding(.horizontal, 5)
                    .padding(.vertical, 0)
            }
            .overlay {
                HStack {
                    Rectangle()
                        .fill(.themePrimary)
                        .frame(width: 1, height: 72)
                        .padding(0)
                    Spacer()
                }
            }
            .frame(height: 72)
            .padding(.leading, 20)
            .padding(.trailing, 12)
            .padding(.vertical, 0)
            
            if item.hasReference {
                downloadReferenceButton
                    .padding(.bottom, 11)
                    .padding(.trailing, 32)
            }
        }
        .contentShape(Rectangle())
    }
    
    private var thumbnailImage: some View {
        AsyncImage(url: URL(string: item.thumbnail)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color(.systemGray4)
        }
        .frame(width: 85, height: 58)
        .clipped()
    }
    
    private var downloadReferenceButton: some View {
        Button {
            if let url = URL(string: item.referenceLink) {
                presentURL = url
            }
        } label: {
            Text("발표자료 받기")
                .foregroundStyle(colorScheme == .dark ? Color(.themeSecondary) : Color(.themePrimary))
                .underline()
                .font(.system(size: 10, weight: .regular))
        }
    }
}

#Preview("Previous") {
    PreviousView()
}

#Preview {
    VideoListView(filteredItems: [], selectedYear: "2024")
}
