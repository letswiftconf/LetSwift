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
        let title: LocalizedStringResource
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
                case appVersion
            }
        }
    }
}

extension More {
    static let data = More(
        sections: [
            More.Section(
                title: "홈페이지",
                cells: [
                    More.Section.Cell(
                        title: "Let'Swift 2024 홈페이지",
                        titleEn: "Let'Swift 2024 Homepage",
                        type: .openUrl(url: More.Constants.homepageURL)
                    ),
                    More.Section.Cell(
                        title: "Let'Swift 2024 운영진",
                        titleEn: "Let'Swift 2024 Organizer",
                        type: .openUrl(url: More.Constants.organizerURL)
                    ),
                ]
            ),
            More.Section(
                title: "구독",
                cells: [
                    More.Section.Cell(
                        title: "뉴스레터 구독",
                        titleEn: "Subscribe newsletter",
                        type: .openUrl(url: More.Constants.subscribeNewsletterURL)
                    ),
                ]
            ),
            More.Section(
                title: "소스 코드",
                cells: [
                    More.Section.Cell(
                        title: "앱 소스 코드",
                        titleEn: "App source code on Github",
                        type: .openUrl(url: More.Constants.githubURL)
                    ),
                ]
            ),
            More.Section(
                title: "앱",
                cells: [
                    More.Section.Cell(
                        title: "앱 리뷰 쓰기",
                        titleEn: "Write an App Review",
                        type: .requestReview
                    ),
                    More.Section.Cell(
                        title: "앱 버전",
                        titleEn: "Version",
                        type: .appVersion
                    ),
                ]
            ),
        ]
    )
}

extension More {
    private enum Constants {
        static let organizerURL: String = "https://letswift.kr/2024/#organizers"
        static let subscribeNewsletterURL: String = "https://page.stibee.com/subscriptions/58654"
        static let homepageURL: String = "https://letswift.kr/2024/"
        static let githubURL: String = "https://github.com/letswiftconf/LetSwift/tree/2024/develop"
    }
}
