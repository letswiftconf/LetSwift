//
//  EventView.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import SwiftUI

struct EventView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Image(event.titleImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
            if event.isOnAir {
                HStack {
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .foregroundColor(.red)
                    Text("LIVE")
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            
            Text(event.title)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Text(event.description)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.leading, .trailing], 10)
            HStack(alignment: .center) {
                Text("\(event.date) \(event.dayOfTheWeek) \(event.time)")
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
        let manager = CalendarManager()
        switch manager.authorizationStatus {
        case .authorized:
            manager.addSession(title: event.title, date: event.date, time: event.time)
        case .denied, .restricted:
            // TODO: Show error
            break
        case .notDetermined:
            manager.requestAccess { (granted, error) in
                self.addToCalendar()
            }
        @unknown default:
            #if DEBUG
            fatalError()
            #endif
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventView(
                event: Event(titleImage: "LogoLetter",
                             title: "SwiftUI vs UIKit",
                             description: "설명",
                             date: "11월 22일",
                             dayOfTheWeek: "수",
                             time: "19:00 - 21:00")
            )
        }.previewLayout(.sizeThatFits)
    }
}
