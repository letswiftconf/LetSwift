//
//  HomeLink.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
//

import Foundation

enum HomeLink: Identifiable, CaseIterable {
    
    case newsletter
    case event
    case festa
    
    var id: String {
        self.urlString
    }
    
    var title: String {
        switch(self) {
        case .newsletter: return "뉴스레터 구독"
        case .event: return "홈페이지"
        case .festa: return "티켓 구매"
        }
    }
    
    var iconName: String {
        switch(self) {
        case .newsletter: return "envelope.open.fill"
        case .event: return "display"
        case .festa: return "ticket.fill"
        }
    }
    
    var urlString: String {
        switch(self) {
        case .newsletter: return Constants.URL.newsletterSubscribeURL
        case .event: return Constants.URL.eventURL
        case .festa: return Constants.URL.festaURL
        }
    }
    
    var url: URL {
        switch self {
        case .newsletter: return URL.letswiftNewsletter
        case .event: return URL.letswiftHome
        case .festa: return URL.ticketaco2025
        }
    }
}
