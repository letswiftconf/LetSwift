//
//  NewsletterItemView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/23.
//

import SwiftUI

struct NewsletterItemView: View {
    let height: CGFloat
    
    @State private var presentNewsletter = false
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("newsletter")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: height)
            VStack(alignment: .leading) {
                Text("뉴스레터 구독")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding()
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
        .sheet(isPresented: $presentNewsletter) {
            #if (iOS)
            Safari(url: .newsletter)
            #endif
        }
        .onTapGesture {
            presentNewsletter.toggle()
        }
    }
}

// MARK: - Preview
struct NewsletterView_Previews: PreviewProvider {
    static var previews: some View {
        NewsletterItemView(height: .homeItemHeight)
            .previewAsComponent()
    }
}
