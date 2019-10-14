//
//  PersonView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/24.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PersonView: View {
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack {
                    Rectangle()
                        .fill(Color(.secondarySystemBackground))
                        .frame(height: 180)
                    Circle()
                        .fill(Color(.tertiarySystemFill))
                        .frame(height: 120)
                }
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .font(.headline)
                        Text("Description")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(0)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Role")
                            .font(.headline)
                        HStack {
                            Text("Organizer")
                                .padding(6)
                                .background(Color.orange)
                                .cornerRadius(9)
                            Text("Staff")
                                .padding(6)
                                .background(Color.orange)
                                .cornerRadius(9)
                        }
                        .font(.footnote)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                    Text("Social Media")
                        .font(.headline)
                    VStack {
                        ForEach(1...3, id: \.self) { _ in
                            Rectangle()
                                .fill(Color.blue)
                                .frame(height: 44)
                                .cornerRadius(9, antialiased: true)
                        }
                    }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Name", displayMode: .inline)
    }
}

// MARK: - Preview
struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                PersonView()
            }
            NavigationView {
                PersonView()
            }
            .environment(\.colorScheme, .dark)
            NavigationView {
                PersonView()
            }
            .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
