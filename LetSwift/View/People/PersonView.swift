//
//  PersonView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/24.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PersonView: View {
    @State var person: SuperPerson
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack {
                    Rectangle()
                        .fill(Color(.secondarySystemBackground))
                        .frame(height: 180)
                    Image(person.name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .mask(Circle())
                    
                }
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(person.name)
                            .font(.headline)
                        Text(person.description)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Role")
                            .font(.headline)
                        HStack {
                            if person.name == "김정" {
                                Text("Organizer")
                                    .padding(6)
                                    .background(Color.orange)
                                    .cornerRadius(9)
                            } else {
                                Text("Staff")
                                    .padding(6)
                                    .background(Color.orange)
                                    .cornerRadius(9)
                            }
                            ForEach(person.tags, id: \.self) { tag in
                                Text(tag)
                                .padding(6)
                                .background(Color.orange)
                                .cornerRadius(9)
                            }
                        }
                        .font(.footnote)
                    }
                    
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(person.name), displayMode: .inline)
    }
}

// MARK: - Preview
struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        
        let people = ProtoStaff.makeProtoData()
        return Group {
            NavigationView {
                PersonView(person: people[1])
            }
            NavigationView {
                PersonView(person: people[0])
            }
            .environment(\.colorScheme, .dark)
            NavigationView {
                PersonView(person: people[0])
            }
            .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
