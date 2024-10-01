//
//  YearKeywordsView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

struct YearKeywordsView: View {
    @Binding var selectedYear: String
    let years: [String]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(years, id: \.self) { year in
                        items(year)
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.leading, 5)
            .padding(.bottom, 18)
            .onChange(of: selectedYear) { oldValue, newValue in
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
    
    @ViewBuilder
    func items(_ year: String) -> some View {
        Text(year)
            .padding(.horizontal, 13)
            .padding(.vertical, 6)
            .background(selectedYear == year ? .primaryPink.opacity(0.2) : .gray2)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        selectedYear == year ? .primaryPink : .clear,
                        lineWidth: 1
                    )
            )
            .foregroundStyle(selectedYear == year ? .primaryPink : .gray9)
            .font(selectedYear == year ? .semiBold(size: 13) : .regular(size: 13))
            .cornerRadius(30)
            .onTapGesture {
                selectedYear = year
            }
    }
}
