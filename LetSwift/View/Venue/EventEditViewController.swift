//
//  EventEditViewController.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/01.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI
import EventKit
import EventKitUI

struct EventEditViewController: UIViewControllerRepresentable {
    // MARK: - Representable
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let viewController = EKEventEditViewController()
//        vc.eventStore = nil
        
        let store =  EKEventStore()
        let event = EKEvent(eventStore: store)
        let start = Date()
        let end = Date()
        event.calendar = store.calendars(for: .event).first
        event.title = "Let'Swift 2019"
        event.location = "양재 aT 센터"
        event.notes = ""
        event.url = nil
        event.startDate = start
        event.endDate = end
        viewController.event  = event
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {
        
    }
}

// MARK: - Preview
struct EventUIVIew_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            EventEditViewController()
        }
    }
}
