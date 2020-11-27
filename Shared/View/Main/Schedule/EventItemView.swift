//
//  EventView.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import SwiftUI

struct EventItemView: View {
    @State var addScheduleSuccess: Bool = false
    
    let event: Event
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Image(event.titleImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    if event.isOnAir {
                        OnAirIconView()
                    }
                    Text(event.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("\(event.date) \(event.dayOfTheWeek) \(event.time)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text(event.description)
                        .font(.footnote)
                    Button("Add to Calendar", action: addToCalendar)
                        .alert(isPresented: $addScheduleSuccess) {
                            Alert(title: Text("캘린더"),
                                  message: Text("캘린더에 일정이 추가되었습니다. 잊지말고 보러오세요!"),
                                  dismissButton: .default(Text("확인")))
                        }
                }
                Spacer()
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
    }
    
    // MARK: - Action
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

// MARK: - Preview
struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventItemView(event: Event(id: 0,
                                   titleImage: "Placeholder",
                                   title: "Title",
                                   description: "Cras justo odio, dapibus ac facilisis in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.",
                                   date: "Dec 1",
                                   dayOfTheWeek: "Fri",
                                   time: "19:00"))
            .previewAsComponent()
    }
}
