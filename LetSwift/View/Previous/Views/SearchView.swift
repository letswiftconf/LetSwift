//
//  SearchView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

// MARK: - Search View
struct SearchView: View {
  @Binding var searchText: String
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundStyle(.gray5)
      
      TextField(
        text: $searchText,
        label: {
          Text("세션 이름을 검색해보세요")
            .foregroundStyle(.gray5)
        }
      )
      .foregroundStyle(.white)
    }
    .padding(.horizontal, 18)
    .padding(.vertical, 12)
    .overlay(
      RoundedRectangle(cornerRadius: 30)
        .stroke(.gray5, lineWidth: 1)
    )
    .padding(.horizontal, 15)
    .padding(.vertical, 18)
  }
}

