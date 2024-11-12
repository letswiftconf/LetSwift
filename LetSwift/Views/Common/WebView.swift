//
//  WebView.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/29.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var urlToload: String?
    
    func makeUIView(context: Context) -> some UIView {
        let link = urlToload ?? "https://www.naver.com/"
        guard let url = URL(string: link) else { return WKWebView() }
        let webview = WKWebView()
        
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    WebView()
}
