//
//  SpeakersView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct SpeakersView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("speakers.title")
                .font(.headline)
            LazyVGrid(columns: columns, alignment: .center) {
                Circle()
                    .foregroundStyle(Color(.systemGroupedBackground))
                    .padding()
                Circle()
                    .foregroundStyle(Color(.systemGroupedBackground))
                    .padding()
                Circle()
                    .foregroundStyle(Color(.systemGroupedBackground))
                    .padding()
                Circle()
                    .foregroundStyle(Color(.systemGroupedBackground))
                    .padding()
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            SpeakersView()
        }
        .padding(.horizontal)
    }
}
