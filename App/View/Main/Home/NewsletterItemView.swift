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
            Image("Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: height)
            VStack(alignment: .leading) {
                Text("뉴스레터")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("구독")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.themePrimary))
            }
            .padding()
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
        .sheet(isPresented: $presentNewsletter) {
            Safari(url: .newsletter)
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
