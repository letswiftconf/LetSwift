//
//  PreviousView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI
import WebKit

struct PreviousView: View {
  @State private var searchText: String = ""
  @State private var videoData: Conference = Conference(year: 2023, items: [])
  @State private var selectedYear: String = "2023"
  private var years = ["2023", "2022", "2019", "2018", "2017", "2016"]
  
  private var filteredItems: [VideoItem] {
    if searchText.isEmpty {
      return videoData.items
    } else {
      return videoData.items.filter { $0.title.contains(searchText) || $0.speaker.contains(searchText) }
    }
  }
  
  var body: some View {
    NavigationView {
      VStack {
        SearchView(searchText: $searchText)
        
        YearKeywords(selectedYear: $selectedYear, years: years)
        
        VideoList(filteredItems: filteredItems, selectedYear: selectedYear)
          .onAppear {
            loadVideoData(for: selectedYear)
          }
          .onChange(of: selectedYear) { _, newYear in
            loadVideoData(for: newYear)
          }
      }
      .background(.black)
    }
    .tabItem {
        Label("previous.title", image: "ic_past")
    }
    .toolbarBackground(.blackBackground, for: .tabBar)
  }
  
  private func loadVideoData(for year: String) {
    videoData = loadJSON(selectedYear: year)
  }
}

// MARK: - Search View
private struct SearchView: View {
  @Binding var searchText: String
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundStyle(.gray5)
      
      TextField(
        text: $searchText,
        label: {
          Text("세션 이름을 검색해보세요")
            .foregroundStyle(.white)
        }
      )
    }
    .padding(.horizontal, 18)
    .padding(.vertical, 12)
    .overlay(
      RoundedRectangle(cornerRadius: 30)
        .stroke(.gray5, lineWidth: 1)
    )
    .padding(.horizontal, 15)
    .padding(.vertical, 18)
  }
}

// MARK: - Year Keyword
private struct YearKeywords: View {
  @Binding var selectedYear: String
  var years: [String]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: true) {
      HStack(spacing: 10) {
        ForEach(years, id: \.self) { year in
          Text(year)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(.gray2)
            .overlay(
              RoundedRectangle(cornerRadius: 30)
                .stroke(
                  selectedYear == year ? .primaryPink : .clear,
                  lineWidth: 3
                )
            )
            .foregroundStyle(selectedYear == year ? .primaryPink : .gray9)
            .fontWeight(selectedYear == year ? .bold : .regular)
            .cornerRadius(30)
            .onTapGesture {
              selectedYear = year
            }
        }
      }
      .padding(.horizontal, 10)
    }
    .padding(.leading, 5)
    .padding(.bottom, 18)
  }
}

// MARK: - Video List
private struct VideoList: View {
  let filteredItems: [VideoItem]
  let selectedYear: String
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack(spacing: 0) {
        ForEach(filteredItems) { item in
          NavigationLink(destination: VideoPlayerView(videoID: item.videoID, selectedYear: selectedYear)) {
            VStack(spacing: 0) {
              Divider()
                .background(Color.white.opacity(0.5))
              
              Spacer()
              
              HStack(alignment: .center) {
                AsyncImage(url: URL(string: item.thumbnail)) { image in
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                } placeholder: {
                  Color.white
                }
                .frame(width: 110, height: 80)
                .padding(.leading, 18)
                
                VStack(alignment: .leading) {
                  Text(item.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.vertical, 4)
                    .lineLimit(2)
                  HStack {
                    Text(item.speaker)
                      .font(.subheadline)
                      .foregroundStyle(.gray9)
                      .lineLimit(1)
                      .padding(.trailing, 5)
                    Text(item.timeLine)
                      .font(.subheadline)
                      .foregroundStyle(.gray9)
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

// MARK: - VideoPlayerView
private struct VideoPlayerView: View {
  let videoID: String
  let selectedYear: String
  
  var body: some View {
    VideoView(url: URL(string: "https://www.youtube.com/watch?v=\(videoID)")!)
      .navigationTitle("LetSwift \(selectedYear)")
  }
}

// MARK: - WebView for Displaying YouTube Videos
private struct VideoView: UIViewRepresentable {
  let url: URL
  
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    uiView.load(URLRequest(url: url))
  }
}

// MARK: - LoadJson
private func loadJSON(selectedYear: String) -> Conference {
  guard let url = Bundle.main.url(forResource: "playlist-"+selectedYear, withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let videoData = try? JSONDecoder().decode(Conference.self, from: data) else {
    fatalError("Failed to load or parse JSON")
  }
  return videoData
}

#Preview {
  PreviousView()
}
