//
//  YearKeywordsView.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import SwiftUI

struct YearKeywordsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var selectedYear: String
    let years: [String]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(years, id: \.self) { year in
                        if #available(iOS 26.0, *), colorScheme == .dark {
                            items(year)
                                .glassEffect()
                        } else {
                            items(year)
                        }
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
            .background(selectedYear == year ? .themePrimary.opacity(0.2) : Color(.secondarySystemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        selectedYear == year ? .themePrimary : .clear,
                        lineWidth: 1
                    )
            )
            .foregroundStyle(selectedYear == year ? .themePrimary : .secondary)
            .font(selectedYear == year ? .system(size: 13, weight: .semibold) : .system(size: 13))
            .cornerRadius(30)
            .onTapGesture {
                selectedYear = year
            }
    }
}

#Preview("Previous") {
    PreviousView()
}
