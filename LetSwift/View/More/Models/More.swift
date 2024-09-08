//
//  More.swift
//  LetSwift
//
//  Created by Philip Chung on 9/5/24.
//

import Foundation

struct More {
    let sections: [Section]
    
    struct Section: Identifiable {
        var id: String = UUID().uuidString
        let cells: [Cell]
        
        struct Cell: Identifiable {
            var id: String = UUID().uuidString
            let title: String
            let titleEn: String
            let type: CellType
            
            enum CellType {
                case navigate(_ route: any Hashable)
                case openUrl(url: String)
                case requestReview
            }
        }
    }
}

extension More {
    static let data = More(
        sections: [
            More.Section(
                cells: [
                    More.Section.Cell(
                        title: "Let'Swift 2024 운영진",
                        titleEn: "Let'Swift 2024 Organizer",
                        type: .openUrl(url: More.Constants.organizerURL)
                    ),
                    More.Section.Cell(
                        title: "뉴스레터 구독",
                        titleEn: "Subscribe newsletter",
                        type: .openUrl(url: More.Constants.subscribeNewsletterURL)
                    ),
                    More.Section.Cell(
                        title: "Let'Swift 2024 홈페이지",
                        titleEn: "Let'Swift 2024 Homepage",
                        type: .openUrl(url: More.Constants.homepageURL)
                    ),
                ]
            ),
            More.Section(
                cells: [
                    More.Section.Cell(
                        title: "Github",
                        titleEn: "Github",
                        type: .openUrl(url: More.Constants.githubURL)
                    ),
                    More.Section.Cell(
                        title: "앱 리뷰쓰기",
                        titleEn: "Write an App Review",
                        type: .requestReview
                    ),
                ]
            ),
        ]
    )
}

extension More {
    private enum Constants {
        static let organizerURL: String = "https://letswift.kr/2024/"   // TODO: URL 미정
        static let subscribeNewsletterURL: String = "https://page.stibee.com/subscriptions/58654"
        static let homepageURL: String = "https://letswift.kr/2024/"
        static let githubURL: String = "https://github.com/letswiftconf/LetSwift/tree/2024/develop"
    }
}
