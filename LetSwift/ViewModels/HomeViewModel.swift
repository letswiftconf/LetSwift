//
//  HomeViewModel.swift
//  LetSwift
//
//  Created by duri on 11/12/24.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    private(set) var outlinks: [HomeLink]
    
    init() {
        outlinks = HomeLink.allCases
    }
    
    @MainActor
    public func open(_ urlString: String) {
        Task {
            if let url = URL(string: urlString) {
                await UIApplication.shared.open(url)
            }
        }
    }
}

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
        case .festa: return "페스타"
        }
    }
    
    var iconName: String {
        switch(self) {
        case .newsletter: return "ic_newsletter"
        case .event: return "ic_homepage"
        case .festa: return "ic_festa"
        }
    }
    
    var urlString: String {
        switch(self) {
        case .newsletter: return Constants.URL.newsletterSubscribeURL
        case .event: return Constants.URL.eventURL
        case .festa: return Constants.URL.festaURL
        }
    }
}
