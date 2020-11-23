//
//  HomeView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: .homeItemVSpacing) {
                HeroItemView(height: .homeItemHeight)
                GeometryReader { geometry in
                    let width = (geometry.size.width - CGFloat.homeItemHSpacing) / 2
                    let height = geometry.size.height
                    HStack(spacing: .homeItemHSpacing) {
                        GetTicketItemView(width: width, height: height)
                        AskQuestionItemView(width: width, height: height)
                    }
                }
                .frame(height: .homeItemHeight)
                NewsletterItemView(height: .homeItemHeight)
                GeometryReader { geometry in
                    let width = (geometry.size.width - CGFloat.homeItemHSpacing) / 2
                    let height = geometry.size.height
                    HStack(spacing: .homeItemHSpacing) {
                        AppSourceCodeItemView(width: width, height: height)
                        WebSourceCodeItemView(width: width, height: height)
                    }
                }
                .frame(height: .homeItemHeight)
                PastEventItemView(height: .homeItemHeight)
            }
            .padding(.horizontal)
        }
        .navigationTitle("홈")
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
        .previewAsComponent()
    }
}
