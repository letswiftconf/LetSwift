//
//  PersonCell.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/09/24.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct PersonCell: View {
    var person: SuperPerson
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(person.imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            VStack(alignment: .center) {
                Text(person.name)
                    .font(.body)
                    .foregroundColor(Color(.label))
                Text(person.organization)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Spacer()
        }
    }
}

// MARK: - Preview
struct PersonCell_Previews: PreviewProvider {
    static var previews: some View {
        let layout = PreviewLayout.fixed(width: 320, height: 200)
        let people = ProtoStaff.makeProtoData()
        return Group {
            PersonCell(person: people[0])
                .previewLayout(layout)
            PersonCell(person: people[10])
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            PersonCell(person: people[15])
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
