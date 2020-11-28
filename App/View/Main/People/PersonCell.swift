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
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(person.imageName)
                .resizable()
                .frame(width: width, height: width)
                .clipShape(Circle())
                .modifier(Shadow())
            VStack(spacing: 4) {
                Text(person.name)
                    .font(.headline)
                    .fontWeight(.bold)
                if let organization = person.organization {
                    Text(organization)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.5)
                }
            }
            .lineLimit(1)
        }
    }
}

// MARK: - Preview
struct PeopleCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonCell(person: Person.makeOrganizer()[0])
            PersonCell(person: Person.makePanels()[0])
            PersonCell(person: Person.makeStaff()[0])
        }
        .previewAsComponent()
    }
}
