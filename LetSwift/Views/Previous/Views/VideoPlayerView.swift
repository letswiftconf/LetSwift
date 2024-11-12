//
//  VideoPlayerView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI
import WebKit

struct VideoPlayerView: View {
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
