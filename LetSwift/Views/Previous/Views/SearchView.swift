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
            .foregroundStyle(Color(.systemGray2))
      
      TextField(
        text: $searchText,
        label: {
          Text("세션 이름을 검색해보세요")
            .foregroundStyle(Color(.systemGray2))
            .font(.system(size: 14))
        }
      )
    }
    .padding(.horizontal, 18)
    .padding(.vertical, 7)
    .overlay(
      RoundedRectangle(cornerRadius: 30)
    )
    .padding(.horizontal, 20)
    .padding(.vertical, 18)
  }
}

#Preview {
    PreviousView()
}
