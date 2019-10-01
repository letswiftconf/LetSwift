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
                VStack {
                    Rectangle()
                        .fill(Color(UIColor.secondarySystemBackground))
                        .frame(height: 240)
                        .modifier(RoundedMask())
                        .padding(.horizontal)
                        .onTapGesture(perform: presentHomepage)
                    HStack(alignment: .center) {
                        Button(action: doNothing) {
                            Text("Buy Tickets Now")
                        }
                        Button(action: doNothing) {
                            Text("How to Get to the Conference")
                        }
                    }
                    .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 24) {
                        ExampleHorizontalList(title: "If you like tech related topics")
                        ExampleHorizontalList(title: "If you wannt to improve code")
                        ExampleHorizontalList(title: "If you like discussing")
                        ExampleHorizontalList(title: "Past Video")
                    }
                    .frame(alignment: .leading)
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
        HomeView()
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
