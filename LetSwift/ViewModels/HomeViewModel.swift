//
//  HomeViewModel.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
//

import Foundation
import EventKit

final class HomeViewModel: ObservableObject {
    
    @Published var alert: CustomAlert?
    
    public let mapUrlScheme: String = "http://maps.apple.com/?auid=12764360059818511054&ll=37.550354,127.073169"
    
    private(set) var outlinks: [HomeLink]
    
    private var startDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 a hh시"

        let dateString = "2025년 11월 24일 오전 10시"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        
        return nil
    }
    
    private var endDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 a hh시"

        let dateString = "2025년 11월 24일 오후 4시"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        
        return nil
    }
    
    init() {
        outlinks = HomeLink.allCases
    }
    
    @MainActor
    public func addEvent() {
        Task {
            let store = EKEventStore()
            
            /// 1. 캘린더 권한 확인
            guard try await checkPermission(store) else {
                alert = .noPermission
                return
            }
            
            let event = EKEvent(eventStore: store)
            event.calendar = store.defaultCalendarForNewEvents
            event.title = "Let'Swift 2025"
            event.startDate = startDate
            event.endDate = endDate
            event.timeZone = TimeZone(identifier: "Asia/Seoul")
            event.location = "서울 광진구 능동로 209"

            /// 2. 캘린더 저장
            do {
                try store.save(event, span: .thisEvent)
                alert = .saveEventSuccess
            } catch {
                alert = .failedSaveEvent
            }
        }
    }
    
    private func checkPermission(_ store: EKEventStore) async throws -> Bool {
        let status = EKEventStore.authorizationStatus(for: .event)
        
        if status == .fullAccess || status == .writeOnly {
            return true
        }
        
        guard try await store.requestWriteOnlyAccessToEvents() else {
            return false
        }
        
        return true
    }
}
