//
//  NewsView.swift
//  LetSwift
//
//  Created by HyungJung Kim on 31/10/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI


struct NewsView: View {
    
    // MARK: - body
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.news.title)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom, 8.0)
            Text("\(self.news.date, formatter: Self.dateFormatter)")
                .font(.caption)
                .foregroundColor(Color(.secondaryLabel))
                .padding(.bottom, 8.0)
            Text(self.news.description)
                .font(.subheadline)
        }
    }
    
    // MARK: - internal
    
    @ObservedObject var news: News
    
    // MARK: - private
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .full
        
        return formatter
    }()
    
}
