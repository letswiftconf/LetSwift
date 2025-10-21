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
            if #available(iOS 26, *) {
                scrollContent
                    .padding(.vertical, 8)
                    .onChange(of: selectedYear) { oldValue, newValue in
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
            } else {
                scrollContent
                    .padding(.bottom, 18)
                    .onChange(of: selectedYear) { oldValue, newValue in
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
            }
        }
    }
    
    private var scrollContent: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(years, id: \.self) { year in
                    if #available(iOS 26.0, *), colorScheme == .dark {
                        yearItem(year)
                            .glassEffect()
                    } else {
                        yearItem(year)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.leading, 5)
    }
    
    @ViewBuilder
    func yearItem(_ year: String) -> some View {
        Text(year)
            .frame(width: 66, height: 28)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(selectedYear == year ? Color(.fillRed) : Color(.background3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(
                                selectedYear == year ? .themePrimary : .clear,
                                lineWidth: 1
                            )
                    )
            )
            .foregroundStyle(selectedYear == year ? .accentRed : .white)
            .font(selectedYear == year ? .system(size: 13, weight: .semibold) : .system(size: 13))
            .onTapGesture {
                selectedYear = year
            }
    }
}

#Preview("Previous") {
    PreviousView()
}
