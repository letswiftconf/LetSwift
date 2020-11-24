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
            HStack {
                Spacer()
                VStack(spacing: 30) {
                    ZStack {
                        VStack(spacing: 10) {
                            PersonCell(person: person, type: .large)
                                .fixedSize(horizontal: true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true)
                            HStack {
                                ForEach(person.role, id: \.self) { role in
                                    Text(role.localizedString)
                                        .font(.caption)
                                        .padding([.all], 5)
                                        .overlay(RoundedRectangle(cornerRadius: 5, style: .circular).stroke())
                                }.foregroundColor(.orange)
                            }
                        }
                    }
                    
                    Text(person.description)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(spacing: 10) {
                        ForEach(person.sns, id: \.self) { sns in
                            HStack {
                                Button(action: {
                                    guard let url = sns.url else { return }
                                    UIApplication.shared.open(url)
                                }, label: {
                                    HStack {
                                        Text(sns.localizedString)
                                            .font(.title3)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Image(systemName: "arrow.up.right")
                                            .foregroundColor(.gray)
                                    }
                                })
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding([.leading, .trailing], 10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                        }
                        .padding([.leading, .trailing], 30)
                    }
                }
                Spacer()
            }
        }
        .navigationBarTitle(person.name)
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: People(type: .staff).list[0])
    }
}
