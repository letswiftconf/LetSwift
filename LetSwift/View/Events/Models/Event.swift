//
//  Event.swift
//  LetSwift
//
//  Created by 지준용 on 9/14/24.
//

import SwiftUI


// NFC 또는 QR 사용에 사용할 더미데이터입니다.
enum Event: String, CaseIterable {
    case event1
    case event2
    case event3
    case event4
    case event5
    case event6
    case event7
    case event8
    
    var payload: String {
        return self.rawValue
    }
    
    var image: UIImage {
        switch self.info.type {
        case .organizer:
            UIImage(resource: .stampOrganizer)
        case .sponsor:
            UIImage(resource: .stampSponsor)
        }
    }
    
    var info: EventInfo {
        switch self {
        case .event1:
            EventInfo(title: "이벤트1", type: .sponsor, description: "이벤트1에 대한 설명입니다.")
        case .event2:
            EventInfo(title: "이벤트2", type: .sponsor, description: "이벤트2에 대한 설명입니다.")
        case .event3:
            EventInfo(title: "이벤트3", type: .sponsor, description: "이벤트3에 대한 설명입니다.")
        case .event4:
            EventInfo(title: "이벤트4", type: .organizer, description: "이벤트4에 대한 설명입니다.")
        case .event5:
            EventInfo(title: "이벤트5", type: .organizer, description: "이벤트5에 대한 설명입니다.")
        case .event6:
            EventInfo(title: "이벤트6", type: .organizer, description: "이벤트6에 대한 설명입니다.")
        case .event7:
            EventInfo(title: "이벤트7", type: .sponsor, description: "이벤트7에 대한 설명입니다.")
        case .event8:
            EventInfo(title: "이벤트8", type: .sponsor, description: "이벤트8에 대한 설명입니다.")
        }
    }
    
    struct EventInfo {
        let title: String
        let type: EventType
        let image: Image? = nil
        let description: String
    }
    
    enum EventType {
        case organizer
        case sponsor
    }
}
