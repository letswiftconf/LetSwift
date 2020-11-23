//
//  PersonCell.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/23.
//

import SwiftUI

struct PersonCell: View {
    var person: Person
    
    var body: some View {
        VStack {
            Spacer()
            Image(person.imageName)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            VStack {
                Text(person.name)
                    .font(.body)
                    .bold()
                if let organization = person.organization {
                    Text(organization)
                        .font(.footnote)
                        .italic()
                }
            }
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
    }
}

struct PeopleCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonCell(person: Person.makeOrganizer()[0])
            PersonCell(person: Person.makePanels()[0])
            PersonCell(person: Person.makeStaff()[0])
        }
        .previewLayout(.fixed(width: 300, height: 300))
    }
}
