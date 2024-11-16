//
//  VideoListView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

struct VideoListView: View {
  let filteredItems: [VideoItem]
  let selectedYear: String
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack(spacing: 0) {
        ForEach(filteredItems) { item in
          NavigationLink(destination: VideoPlayerView(videoID: item.videoID, selectedYear: selectedYear)) {
            VStack(spacing: 0) {
              Divider()
                .background(.grayStoke)
              
              Spacer()
              
              HStack(alignment: .center) {
                AsyncImage(url: URL(string: item.thumbnail)) { image in
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                } placeholder: {
                  Color.gray2
                }
                .frame(width: 110, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.leading, 18)
                
                VStack(alignment: .leading) {
                  Text(item.title)
                    .font(.semiBold(size: 15))
                    .foregroundStyle(.whiteText)
                    .padding(.vertical, 4)
                    .lineLimit(2)
                  HStack {
                    Text(item.speaker)
                      .font(.regular(size: 15))
                      .foregroundStyle(.gray8)
                      .lineLimit(1)
                      .padding(.trailing, 5)
                    Text(item.timeLine)
                      .font(.subheadline)
                      .foregroundStyle(.gray8)
                      .lineLimit(1)
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
          .buttonStyle(PlainButtonStyle())
        }
      }
    }
  }
}

#Preview {
  VideoListView(filteredItems: [], selectedYear: "2024")
}
