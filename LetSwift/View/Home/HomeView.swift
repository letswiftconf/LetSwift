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
    @State private var presentsTicket = false
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
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
                        VStack(spacing: 16) {
                            VStack(spacing: 6) {
                                Text("A Change of Season")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Swift 개발자에게 혹독한 변화의 계절을 함께 준비해요")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                            }
                            HStack(alignment: .center, spacing: 16) {
                                Button(action: {
                                    self.presentHomepage()
                                }, label: {
                                    Text("공식 홈페이지")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                })
                                    .padding(.horizontal)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44)
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .circular))
                                    .sheet(isPresented: $presentsHomepage) {
                                        Safari(url: URL(string: "http://letswift.kr/")!)
                                }
                                
                                Button(action: {
                                    self.presentsTicket.toggle()
                                    //                                    https://festa.io/my/tickets/event/111
                                    //                                    https://festa.io/events/602
                                }, label: {
                                    Text("티켓 보기")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                })
                                    .padding(.horizontal)
//                                    .frame(height: 44)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44)
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .circular))
                                    .sheet(isPresented: $presentsTicket) {
                                        Safari(url: URL(string: "https://festa.io/my/tickets/event/602")!)
                                }
                            }
                            .padding(.horizontal)
                        }
                        Divider()
                    }
                    
                    // MARK: - First row
                    if horizontalSizeClass == .regular {
                        HStack {
                            firstRowItems
                        }
                    } else {
                        VStack {
                            firstRowItems
                        }
                    }
                    
                    // MARK: - Second row
                    if horizontalSizeClass == .regular {
                        HStack {
                            secondRowItems
                        }
                    } else {
                        VStack {
                            secondRowItems
                        }
                    }
                    
                    // MARK: - Third row
                    if horizontalSizeClass == .regular {
                        HStack {
                            thirdRowItems
                        }
                    } else {
                        VStack {
                            thirdRowItems
                        }
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
        )
    }
    
    // MARK: - View Component
    private var firstRowItems: some View {
        Group {
            // MARK: - Welcome
            WelcomeItemView("Welcome_iPhone") {
                WelcomeItemContentView(emoji: "🤗",
                                       description1: "2019년 11월 12일",
                                       description2: "양재 at 센터",
                                       title: "행사에서 만나요!")
            }
            
            // MARK: - Entrance
            WelcomeItemView("Welcome_Laptop") {
                WelcomeItemContentView(emoji: "🎟",
                                       description1: "환영합니다!",
                                       description2: "티켓과 기념품을 수령하세요",
                                       title: "행사 입장")
            }
        }
    }
    
    private var secondRowItems: some View {
        Group {
            // MARK: - Session
            WelcomeItemView("Welcome_Session") {
                WelcomeItemContentView(emoji: "🎤",
                                       description1: "난이도 있는",
                                       description2: "기술 주제에 대한",
                                       title: "발표")
            }
            
            // MARK: - Workshop
            WelcomeItemView("Welcome_Workshop") {
                WelcomeItemContentView(emoji: "💻",
                                       description1: "경험 풍부한 개발자와",
                                       description2: "직접 코드 품질을 개선하는",
                                       title: "워크샵")
            }
        }
    }
    
    private var thirdRowItems: some View {
        Group {
            // MARK: - Teatime
            WelcomeItemView("Welcome_Teatime") {
                WelcomeItemContentView(emoji: "🍵",
                                       description1: "작은 주제별로",
                                       description2: "자유롭게 토론하는",
                                       title: "티타임")
            }
            
            // MARK: - People
            WelcomeItemView("People") {
                WelcomeItemContentView(emoji: "👨🏻‍💻🧑🏻‍💻👩🏻‍💻",
                                       description1: "Let'Swift 2019",
                                       description2: "우리 모두 함께해요",
                                       title: "사람들")
            }
        }
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
