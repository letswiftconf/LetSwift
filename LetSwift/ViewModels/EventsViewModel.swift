//
//  EventsViewModel.swift
//  LetSwift
//
//  Created by 지준용 on 10/31/24.
//

import SwiftUI

@Observable
final class EventsViewModel {
    
    // MARK: - Properties
    private(set) var eventCellStates: [Event] = [] {
        didSet {
            saveStamps(of: eventCellStates)
        }
    }
    
    // MARK: - Init
    init() {
        self.eventCellStates = loadStamps()
    }
    
    // MARK: - Methods
    func addStamp(_ event: Event) {
        eventCellStates.append(event)
    }
    
    private func saveStamps(of events: [Event]) {
        UserDefaultsManager.eventStamps = events
    }
    
    private func loadStamps() -> [Event] {
        return UserDefaultsManager.eventStamps
    }
}
