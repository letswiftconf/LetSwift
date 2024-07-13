//
//  SponsorsView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct SponsorsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("sponsors.title")
                .font(.headline)
            VStack(alignment: .center, spacing: 24) {
                Circle()
                    .foregroundStyle(Color(.systemGroupedBackground))
                    .frame(height: 160)
                HStack(alignment: .center, spacing: 16) {
                    Circle()
                        .foregroundStyle(Color(.systemGroupedBackground))
                    Circle()
                        .foregroundStyle(Color(.systemGroupedBackground))
                }
                .frame(height: 130)
                HStack(alignment: .center, spacing: 16) {
                    Circle()
                        .foregroundStyle(Color(.systemGroupedBackground))
                    Circle()
                        .foregroundStyle(Color(.systemGroupedBackground))
                    Circle()
                        .foregroundStyle(Color(.systemGroupedBackground))
                }
                .frame(height: 110)
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            SponsorsView()
        }
        .padding(.horizontal)
    }
}
