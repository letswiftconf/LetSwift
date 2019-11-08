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
                VStack(spacing: 16) {
                    HomeHeroView()
                    
                    // MARK: - Title
                    Group {
                        Divider()
                        VStack(spacing: 6) {
                            Text("A Change of Season")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Swift 개발자에게 혹독한 변화의 계절을 함께 준비해요")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }
                        Divider()
                    }
                    
                    // MARK: - Welcome
                    WelcomeItemView("Welcome_iPhone") {
                        Group {
                            Text("🤗")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("2019년 11월 12일")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("양재 at 센터")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("행사에서 만나요!")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                    }
                    
                    // MARK: - Entrance
                    WelcomeItemView("Welcome_Laptop") {
                        Group {
                            Text("🎟")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("티켓과 기념품을 수령하세요")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("행사 입장")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                    }
                    
                    // MARK: - Session
                    WelcomeItemView("Welcome_Session") {
                        Group {
                            Text("🎤")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("난이도 있는")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("기술 주제에 대한")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("발표")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                    }
                    
                    // MARK: - Workshop
                    WelcomeItemView("Welcome_Workshop") {
                        Group {
                            Text("💻")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("직접 코드 품질을 개선하는")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("워크샵")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                    }
                    
                    // MARK: - Teatime
                    WelcomeItemView("Welcome_Teatime") {
                        Group {
                            Text("🍵")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("작은 주제별로")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("자유롭게 토론하는")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("티타임")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                    }
                    
                    // MARK: - Footer
                    Group {
                        Divider()
                        VStack {
                            Text("2019년 11월 12일 화요일")
                            Text("서울 양재 aT 센터에서 만나요!")
                        }
                        .font(.headline)
                        .padding(.horizontal)
                    }
                    
                    //                    VStack(alignment: .leading, spacing: 24) {
                    //                        ExampleHorizontalList(title: "If you like tech related topics")
                    //                        ExampleHorizontalList(title: "If you wannt to improve code")
                    //                        ExampleHorizontalList(title: "If you like discussing")
                    //                        ExampleHorizontalList(title: "Past Video")
                    //                    }
                    //                    .frame(alignment: .leading)
                }
                .padding(.horizontal)
                Spacer(minLength: 24)
                
                // MARK: - App Info
                VStack {
                    Spacer()
                    HStack {
                        Spacer(minLength: 24)
                        AppInfoView()
                        Spacer(minLength: 24)
                    }
                    Spacer()
                }
                .padding(.vertical)
                .background(Color(.secondarySystemBackground))
            }
            .navigationBarTitle("홈")
            .navigationBarItems(trailing: settingsButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .background(
            EmptyView()
                .sheet(isPresented: $presentsSettings) {
                    SettingsView()
            }
            .background(
                EmptyView()
                    .sheet(isPresented: $presentsHomepage) {
                        SafariView(url:
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
}

// MARK: - Preview
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

// MARK: - Test
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
