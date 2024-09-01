//
//  Settings.swift
//  LetSwift
//
//  Created by Philip Chung on 9/5/24.
//

import Foundation

struct Settings {
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
                case navigate(_ route: any Hashable)    // 범용성 고려해서 case 추가함
                case openUrl(url: String)
            }
        }
    }
}

extension Settings {
    static let data = Settings(
        sections: [
            Settings.Section(
                cells: [
                    Settings.Section.Cell(
                        title: "Let'Swift 2024 운영진",
                        titleEn: "Let'Swift 2024 Organizer",
                        type: .openUrl(url: "https://www.naver.com")
                    ),
                    Settings.Section.Cell(
                        title: "뉴스레터 구독",
                        titleEn: "Subscribe newsletter",
                        type: .openUrl(url: "https://page.stibee.com/subscriptions/58654")
                    ),
                    Settings.Section.Cell(
                        title: "Let'Swift 2024 홈페이지",
                        titleEn: "Let'Swift 2024 Homepage",
                        type: .openUrl(url: "https://letswift.kr/2024/")
                    ),
                ]
            ),
            Settings.Section(
                cells: [
                    Settings.Section.Cell(
                        title: "Github",
                        titleEn: "Github",
                        type: .openUrl(url: "https://github.com/letswiftconf/LetSwift/tree/2024/develop")
                    ),
                    Settings.Section.Cell(
                        title: "앱 리뷰쓰기",
                        titleEn: "Write an App Review",
                        type: .openUrl(url: "https://apps.apple.com/app/id{appID}?action=write-review")
                    ),
                ]
            ),
        ]
    )
}
