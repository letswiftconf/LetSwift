//
//  PastEventsView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct PastEventsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("pastevents.title")
                .font(.headline)
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 23, style: .continuous)
                    .foregroundStyle(Color(.systemGroupedBackground))
                    .frame(height: 80)
                RoundedRectangle(cornerRadius: 23, style: .continuous)
                    .foregroundStyle(Color(.systemGroupedBackground))
                    .frame(height: 80)
                RoundedRectangle(cornerRadius: 23, style: .continuous)
                    .foregroundStyle(Color(.systemGroupedBackground))
                    .frame(height: 80)
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            PastEventsView()
        }
        .padding(.horizontal)
    }
}
