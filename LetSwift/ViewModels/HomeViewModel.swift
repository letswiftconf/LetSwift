//
//  HomeViewModel.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
//

import Foundation
import EventKit

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var alert: CustomAlert?

    public let mapUrlScheme: String = "http://maps.apple.com/?auid=12764360059818511054&ll=37.550354,127.073169"

    private(set) var outlinks: [HomeLink]

    /// Once the conference is over, adding it to the calendar no longer makes sense.
    var canAddToCalendar: Bool {
        !Constants.Conference.isOver
    }

    init() {
        outlinks = HomeLink.allCases.filter { link in
            // Ticket sales end with the conference.
            !(link == .festa && Constants.Conference.isOver)
        }
    }

    public func addEvent() {
        Task {
            let store = EKEventStore()

            /// 1. 캘린더 권한 확인
            guard await checkPermission(store) else {
                alert = .noPermission
                return
            }

            let event = EKEvent(eventStore: store)
            event.calendar = store.defaultCalendarForNewEvents
            event.title = Constants.Conference.name
            event.startDate = Constants.Conference.startDate
            event.endDate = Constants.Conference.endDate
            event.timeZone = Constants.Conference.timeZone
            event.location = Constants.Conference.location

            /// 2. 캘린더 저장
            do {
                try store.save(event, span: .thisEvent)
                alert = .saveEventSuccess
            } catch {
                alert = .failedSaveEvent
            }
        }
    }

    private func checkPermission(_ store: EKEventStore) async -> Bool {
        let status = EKEventStore.authorizationStatus(for: .event)

        if status == .fullAccess || status == .writeOnly {
            return true
        }

        return (try? await store.requestWriteOnlyAccessToEvents()) ?? false
    }
}
