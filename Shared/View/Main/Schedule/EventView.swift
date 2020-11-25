//
//  EventView.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import SwiftUI

struct EventView: View {
    let event: Event
    @State var addScheduleSuccess: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Image(event.titleImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            if event.isOnAir {
                HStack {
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .foregroundColor(.red)
                    Text("LIVE")
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
                .padding(.leading, 10)
            }
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 10)
                    .padding([.top, .bottom], 5)
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
                        .alert(isPresented: $addScheduleSuccess, content: {
                            Alert(title: Text("알림"), message: Text("일정 등록이 완료되었습니다"), dismissButton: .default(Text("확인")))
                        })
                        .foregroundColor(Color(UIColor.link))
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30, alignment: .center)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
            }
            .foregroundColor(.black)
            .background(Color.white)
        }
        .modifier(RoundedMask())
        .shadow(radius: 5)
    }
    
    func addToCalendar() {
        let manager = CalendarManager()
        switch manager.authorizationStatus {
        case .authorized:
            manager.addSession(title: event.title, date: event.date, time: event.time)
            addScheduleSuccess = true
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
    
    func toggleAddingState() {
        addScheduleSuccess = !addScheduleSuccess
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventView(
                event: events[0]
            )
        }.previewLayout(.sizeThatFits)
    }
}
