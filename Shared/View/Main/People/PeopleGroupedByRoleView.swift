//
//  PeopleGroupedByRoleView.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/23.
//

import SwiftUI

struct PeopleGroupedByRoleView: View {
    @EnvironmentObject private var people: People
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            HStack {
                Text(people.title)
                    .font(.title)
                    .bold()
                Spacer()
            }
            containedView()
            Spacer()
        }
    }
    
    func containedView() -> AnyView {
        switch people.type {
        case .organizer:
            return AnyView(PersonCell(person: people.list[0]))
            
        default:
            return AnyView(
                GridView(rows: people.list.count / 3 + 1, columns: 3, content: { (index) in
                    if people.list.count > index {
                        PersonCell(person: people.list[index])
                            .frame(width: 80)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                })
                .padding()
            )
        }
    }
}

struct PeopleGroupedByRoleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PeopleGroupedByRoleView()
                .environmentObject(People(type: .organizer))
        }.previewLayout(.fixed(width: 400, height: 300))
    }
}
