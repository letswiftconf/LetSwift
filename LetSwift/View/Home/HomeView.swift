//
//  HomeView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State private var presentsSettings = false
    @State private var presentsHomepage = false
    
    // MARK: - Button
    private var settingsButton: some View {
        Button(action: presentSettings) {
            Image(systemName: "gear")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Image("Sample")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 240)
                        .modifier(RoundedMask())
                        .padding(.horizontal)
                        .onTapGesture(perform: presentHomepage)
                    Divider()
                        .padding(.horizontal)
                    VStack(alignment: .leading) {
                        Text("A Change of Season")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text("스위프트 개발자에게 혹독한 변화의 계절을 함께 준비해요")
                            .font(.subheadline)
                        Text("\n오픈소스 기반 스위프트 커뮤니티에는 학생부터 10년 넘은 베테랑 개발자까지 다양합니다.\nSwiftUI 와 Combine은 새로운 iOS 개발 경험을 만들어 줄 겁니다.\n")
                            .font(.subheadline)
                        Text("🎤 난이도 있는 기술 토픽에 대한 발표\n💻 직접 코드 품질을 개선하는 워크숍\n🍵 작은 주제별로 자유롭게 토론하는 소규모 티타임\n\n여러분은 어떤 주제에 관심이 있으신가요?")
                            .font(.subheadline)
                    }
                    .padding()
                    Divider()
                        .padding(.horizontal)
                    
                    ForEach(News.dummy) { news in
                        NewsView(news: news)
                            .padding()
                        Divider()
                            .padding(.horizontal)
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Home")
            .navigationBarItems(trailing: settingsButton)
        }
        .background(
            EmptyView()
                .sheet(isPresented: $presentsSettings) {
                    SettingsView()
            }
            .background(
                EmptyView()
                    .sheet(isPresented: $presentsHomepage) {
                        SafariViewController(url:
                            URL(string: "https://letswift.kr/2019")!,
                                             entersReaderIfAvailable: false)
                }
            )
        )
    }
    
    // MARK: - Action
    private func presentSettings() {
        presentsSettings.toggle()
    }
    
    private func presentHomepage() {
        presentsHomepage.toggle()
    }
    
    private func doNothing() {
        
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
            HomeView()
                .environment(\.colorScheme, .dark)
            HomeView()
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
#endif

struct ExampleHorizontalList: View {
    @State var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1...6, id: \.self) { _ in
                        Rectangle()
                            .fill(Color(.tertiarySystemFill))
                            .cornerRadius(9)
                            .frame(width: 160)
                    }
                }
                .frame(height: 100)
                .padding(.horizontal)
            }
        }
    }
}
