//
//  PreviousSessionCacheManager.swift
//  LetSwift
//
//  Created by 윤준수 on 10/20/25.
//


actor PreviousSessionCacheManager {
    static let shared = PreviousSessionCacheManager()
    
    private var conferenceCache: [String: Conference] = [:]
    private var allConferencesCache: Conference?
    
    func conference(forYear year: String) -> Conference? {
        conferenceCache[year]
    }
    
    func updateConferenceCache(year: String, conference: Conference) {
        conferenceCache[year] = conference
    }
    
    func allConferences() -> Conference? {
        allConferencesCache
    }
    
    func updateAllConferencesCache(_ conference: Conference) {
        allConferencesCache = conference
    }
}
