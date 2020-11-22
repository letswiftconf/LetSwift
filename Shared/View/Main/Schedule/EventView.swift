//
//  EventView.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import SwiftUI

struct EventView: View {
    let titleImageName: String
    let title: String
    let description: String
    let date: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Image(titleImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Text(description)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.leading, .trailing], 10)
            HStack(alignment: .center, spacing: 50) {
                Text(date)
                Spacer()
                Button("Add to Calendar", action: addToCalendar)
                    .frame(alignment: .trailing)
            }
            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: 30, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
        }
        .modifier(RoundedMask())
    }
    
    func addToCalendar() {
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventView(
                titleImageName: "LogoLetter",
                title: "타이틀",
                description: "설명",
                date: "날짜"
            )
        }.previewLayout(.sizeThatFits)
    }
}
