//
//  CalendarManager.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/01.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import EventKit
import os.log

class CalendarManager {
    private lazy var store = EKEventStore()
    
    // MARK: - Initialization
    init() {
        
    }
    
    // MARK: - Permission
    var authorizationStatus: EKAuthorizationStatus {
        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
        case .authorized:
            os_log(.info, log: .default, "Calendar access authorized")
        case .denied:
            os_log(.info, log: .default, "Calendar access denied")
        case .restricted:
            os_log(.info, log: .default, "Calendar access restricted")
        case .notDetermined:
            os_log(.info, log: .default, "Calendar access not determined")
        @unknown default:
            #if DEBUG
            fatalError()
            #endif
        }
        return status
    }
    
    func requestAccess(_ completion: @escaping EKEventStoreRequestAccessCompletionHandler) {
        os_log(.info, log: .default, "Requesting calendar access")
        store.requestAccess(to: .event) { (granted, error) in
            if granted {
                os_log(.info, log: .default, "Calendar access granted")
            } else if let error = error {
                os_log(.error, log: .default, "Calendar access not granted with error - %{PUBLIC}@", error.localizedDescription)
            } else {
                os_log(.error, log: .default, "Calendar access not granted")
            }
            completion(granted, error)
        }
    }
    
    // MARK: - Action
    func addConference2019() {
        let event = EKEvent(eventStore: store)
        let start = Date()
        let end = Date()
        event.calendar = store.defaultCalendarForNewEvents
        event.title = "Let'Swift 2019"
        event.location = "양재 aT 센터"
        event.notes = ""
        event.url = nil
        event.startDate = start
        event.endDate = end
        
        do {
            try store.save(event, span: .thisEvent)
        } catch {
            #if DEBUG
            fatalError()
            #endif
        }
    }
    
    func addSession(title: String, startsAt: Date, endsAt: Date) {
        let event = EKEvent(eventStore: store)
        event.title = "Let'Swift: \(title)"
        event.startDate = startsAt
        event.endDate = endsAt
        event.calendar = store.calendars(for: .event).first
       
        do {
            try store.save(event, span: .thisEvent)
        } catch {
            #if DEBUG
            fatalError(error.localizedDescription)
            #endif
        }
    }
}
