//
//  PersonCell.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/23.
//

import SwiftUI

enum ProfileType {
    case small
    case large
}

struct PersonCell: View {
    var person: Person
    var type: ProfileType = .small
    private var width: CGFloat {
        switch type {
        case .small:
            return 80
        case .large:
            return 160
        }
    }
    private var titleFont: Font {
        switch type {
        case .small:
            return .body
        case .large:
            return .title
        }
    }
    private var organizationFont: Font {
        switch type {
        case .small:
            return .footnote
        case .large:
            return .title3
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image(person.imageName)
                .resizable()
                .frame(width: width, height: width)
                .clipShape(Circle())
            VStack {
                Text(person.name)
                    .font(titleFont)
                    .foregroundColor(Color(UIColor.label))
                    .bold()
                    .minimumScaleFactor(0.5)
                if let organization = person.organization {
                    Text(organization)
                        .font(organizationFont)
                        .foregroundColor(Color(UIColor.label))
                        .italic()
                        .minimumScaleFactor(0.5)
                }
            }
            .lineLimit(1)
            .multilineTextAlignment(.center)
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
