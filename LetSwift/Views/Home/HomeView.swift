//
//  HomeView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Image("banner1")
                .frame(height: 91)
                .aspectRatio(contentMode: .fit)
                .padding(.vertical, 53)
            
            VStack(spacing: 16) {
                LocationAndDateView {
                    print("onTapMapButton")
                } onTapCalendarButton: {
                    print("onTapCalendarButton")
                }

                buttonStack
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .background(.darkBackground)
    }
    
    var buttonStack: some View {
        HStack(spacing: 16) {
            ForEach(viewModel.outlinks) { link in
                LinkButton(title: link.title, icon: link.iconName) {
                    viewModel.open(link.urlString)
                }
            }
        }
    }
    
}

#Preview {
    TabView {
        HomeView()
    }
    .environment(\.locale, .init(identifier: "ko"))
}
