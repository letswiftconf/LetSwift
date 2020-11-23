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
        ScrollView {
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    PersonCell(person: person, type: .large)
                        .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    HStack {
                        ForEach(person.role, id: \.self) { role in
                            Text(role)
                                .font(.body)
                                .padding([.all], 5)
                                .overlay(RoundedRectangle(cornerRadius: 5, style: .circular).stroke())
                        }
                    }
                }
                
                Text(person.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                VStack {
                    ForEach(1...3, id: \.self) { _ in
                        HStack {
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                HStack {
                                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                        .foregroundColor(.gray)
                                }
                            })
                        }
                        .frame(height: 50)
                        .padding([.leading, .trailing], 10)
                        Divider()
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 5, style: .circular).stroke())
                .padding([.leading, .trailing], 30)
            }
            .padding()
        }
        .navigationBarTitle("Name")
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: People(type: .panels).list[0])
    }
}
