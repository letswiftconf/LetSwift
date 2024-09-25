//
//  YearKeywordsView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

struct YearKeywordsView: View {
  @Binding var selectedYear: String
  var years: [String]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: true) {
      HStack(spacing: 10) {
        ForEach(years, id: \.self) { year in
          Text(year)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(.gray2)
            .overlay(
              RoundedRectangle(cornerRadius: 30)
                .stroke(
                  selectedYear == year ? .primaryPink : .clear,
                  lineWidth: 3
                )
            )
            .foregroundStyle(selectedYear == year ? .primaryPink : .gray9)
            .fontWeight(selectedYear == year ? .bold : .regular)
            .cornerRadius(30)
            .onTapGesture {
              selectedYear = year
            }
        }
      }
      .padding(.horizontal, 10)
    }
    .padding(.leading, 5)
    .padding(.bottom, 18)
  }
}
