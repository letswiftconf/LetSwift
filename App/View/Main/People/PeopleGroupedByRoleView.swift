//
//  PeopleGroupedByRoleView.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/23.
//

import SwiftUI

struct PeopleGroupedByRoleView: View {
    @EnvironmentObject private var people: People
    
    var numOfItemsInRow: Int {
        switch UIDevice.current.model {
        case "iPhone":
            return 3
        default:
            return 5
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
//            Spacer()
            HStack {
                Text(people.title)
                    .font(.title3)
                    .bold()
                Spacer()
            }
            containedView()
//            Spacer()
        }
    }
    
    func containedView() -> AnyView {
        switch people.type {
        case .organizer:
            return AnyView(
                NavigationLink(
                    destination: PersonDetailView(person: people.list[0])) {
                    PersonCell(person: people.list[0])
                }
            )
            
        default:
            let row = Int(ceil(Double(people.list.count) / Double(numOfItemsInRow)))
            return AnyView(
                GridView(rows: row, columns: numOfItemsInRow, content: { (index) in
                    if people.list.count > index {
                        NavigationLink(
                            destination: PersonDetailView(person: people.list[index])) {
                            PersonCell(person: people.list[index])
                                .frame(width: 80)
                                .fixedSize(horizontal: true, vertical: false)
                        }
                    } else {
                        PersonCell(person: Person.makeDummy())
                            .frame(width: 80)
                            .hidden()
                    }
                })
                .padding()
            )
        }
    }
}

// MARK: - Preview
struct PeopleGroupedByRoleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PeopleGroupedByRoleView()
                .environmentObject(People(type: .staff))
        }
        .previewAsComponent()
    }
}
