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
        let encoder = JSONEncoder()
        
        if let encodedObject = try? encoder.encode(events) {
            UserDefaults.standard.set(encodedObject, forKey: "events")
        }
    }
    
    private func loadStamps() -> [Event] {
        guard let savedEvents = UserDefaults.standard.object(forKey: "events") as? Data else { return [] }
        
        let decoder = JSONDecoder()
        guard let decodedObjects = try? decoder.decode([Event].self,
                                                       from: savedEvents) else { return [] }
        return decodedObjects
    }
}
