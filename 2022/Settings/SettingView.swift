//
//  SettingView.swift
//  LetSwift
//
//  Created by Hani on 2023/08/20.
//

import SwiftUI
import SafariServices

struct SettingView: View {
    @State var showSafari = false
    @State var link: URL?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Link(destination: URLData.newsletter) {
                    settingBox(title: "뉴스레터 구독")
                        .padding(.bottom, 40)
                }
                
                Link(destination: URLData.homePage2022) {
                    settingBox(title: "2022 공식 홈페이지")
                }
                
                NavigationLink {
                    SwiftWebView()
                } label: {
                    settingBox(title: "역대 레츠 스위프트")
                }
                
                Link(destination: URLData.webSourceCode) {
                    settingBox(title: "웹 소스코드")
                }
                
                Link(destination: URLData.appSourceCode) {
                    settingBox(title: "앱 소스코드")
                }
                
                settingBox(title: "앱 리뷰쓰기")
                    .onTapGesture {
                        moveToAppstoreComment()
                    }
            }
            .padding(.horizontal, 20)
            .ignoresSafeArea()
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.backgroundBlack)
        .foregroundColor(.white)
    }
}


extension SettingView {
    @ViewBuilder func settingBox(title: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadRegular)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.subheadRegular)
        }
        .padding(.bottom, 30)
        .contentShape(Rectangle())
    }
    
    private func moveToAppstoreComment() {
        let appstoreUrl = URLData.appStoreReview
        var urlComp = URLComponents(url: appstoreUrl, resolvingAgainstBaseURL: false)
        urlComp?.queryItems = [
            URLQueryItem(name: "action", value: "write-review")
        ]
        guard let reviewUrl = urlComp?.url else {
            return
        }
        UIApplication.shared.open(reviewUrl, options: [:], completionHandler: nil)
    }
}

#Preview {
    SettingView()
}
