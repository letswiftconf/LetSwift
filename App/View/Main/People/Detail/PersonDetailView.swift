//
//  PersonDetailView.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/23.
//

import SwiftUI

struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 30) {
                    VStack(spacing: 8) {
                        PersonCell(person: person, type: .large)
                            .fixedSize(horizontal: true, vertical: true)
                        HStack {
                            ForEach(person.role, id: \.self) { role in
                                Text(role.localizedString)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color(.themePrimary))
                                    .cornerRadius(6)
                            }
                        }
                    }
                    
                    Text(person.description)
                        .font(.body)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(spacing: 8) {
                        ForEach(person.sns, id: \.self) { sns in
                            Button(action: {
                                open(url: sns.url)
                            }, label: {
                                HStack {
                                    Text(sns.localizedString)
                                        .font(.body)
                                        .foregroundColor(Color(.label))
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                            })
                            .background(Color(.secondarySystemGroupedBackground))
                            .cornerRadius(13)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(person.name)
    }
    
    // MARK: - Action
    private func open(url: URL?) {
        guard let url = url else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Preview
struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
//            PersonDetailView(person: People(type: .staff).list[0])
            PersonDetailView(person: Person(name: "Name",
                                            organization: "Organization",
                                            role: [.organizer, .devApp, .staff],
                                            description: "Etiam porta sem malesuada magna mollis euismod. Aenean lacinia bibendum nulla sed consectetur. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.",
                                            sns: [.email("ksquareatm@gmail.com")]))
        }
        .previewAsScreen()
    }
}
