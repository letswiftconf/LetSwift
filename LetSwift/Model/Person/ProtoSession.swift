//
//  ProtoSession.swift
//  LetSwift
//
//  Created by BumMo Koo on 02/11/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

struct ProtoSession: Identifiable {
    var id: String {
        return title
    }
    let title: String
    let speaker: String
    let level: String
    let time: String
}

extension ProtoSession {
    static let sessions: [ProtoSession] = [
        ProtoSession(title: "키노트+컨퍼런스를 즐기는 방법",
                     speaker: "김정",
                     level: "중",
                     time: "09:30 - 09:50"),
        ProtoSession(title: "RxSwift to Combine (feat. SwiftUI",
                     speaker: "박보영",
                     level: "중",
                     time: "10:00 - 10:40"),
        ProtoSession(title: "Behind Scene of Delightful Experience",
                     speaker: "백성욱",
                     level: "중",
                     time: "10:50 - 11:10"),
        ProtoSession(title: "미려한 UI/UX를 위한 여정",
                     speaker: "강승철",
                     level: "고",
                     time: "11:20 - 12:00"),
        ProtoSession(title: "MVC, MVVM, ReactorKit, Viper를 거쳐 RIB 정착기",
                     speaker: "안정민",
                     level: "중",
                     time: "13:00 - 13:40"),
        ProtoSession(title: "Swift in SwiftUI",
                     speaker: "이봉원",
                     level: "중",
                     time: "13:50 - 14:10"),
        ProtoSession(title: "Xcode Previews - IB 없이 개발하기",
                     speaker: "김남현",
                     level: "중",
                     time: "14:20 - 15:00"),
        ProtoSession(title: "RxTesting 같이 시작하기",
                     speaker: "이병찬",
                     level: "고",
                     time: "15:10 - 15:30"),
        ProtoSession(title: "iOS 앱에서 머신러닝이 해결할 수 있는 문제들",
                     speaker: "곽도영",
                     level: "중",
                     time: "15:40 - 16:20"),
        ProtoSession(title: "코드로 iOS UI 편하게 작업하기 위한 라이브러리 작업",
                     speaker: "이정우",
                     level: "중",
                     time: "16:20 - 16:40")
    ]
    
    static let teatime: [ProtoSession] = [
        ProtoSession(title: "스타트업 개발자 (주니어의 성장, 서비스, 개발 문화)",
                     speaker: "김용성, 김건우",
                     level: "초",
                     time: "13:00 - 13:50"),
        ProtoSession(title: "iOS 프리랜서 생활",
                     speaker: "장왕수",
                     level: "초",
                     time: "13:00 - 13:50"),
        ProtoSession(title: "개발자와의 심리전 - SDK 개발",
                     speaker: "황규영",
                     level: "중",
                     time: "14:00 - 14:50"),
        ProtoSession(title: "주니어 개발자의 성장하는 글쓰기",
                     speaker: "이규원",
                     level: "초",
                     time: "14:00 - 14:50"),
        ProtoSession(title: "여러 회사 개발 문화와 커뮤네케이션",
                     speaker: "권문범, 김윤봉",
                     level: "초",
                     time: "15:00 - 15:50"),
        ProtoSession(title: "쏘카의 개발 문화",
                     speaker: "우경재",
                     level: "초",
                     time: "15:00 - 15:50"),
        ProtoSession(title: "공짜로 WWDC 가는법(스칼라십)",
                     speaker: "조성현, 이재성, 김민혁",
                     level: "초",
                     time: "16:00 - 16:50"),
        ProtoSession(title: "스타일쉐어 iOS팀 개발 문화",
                     speaker: "김동현, 김우성, 윤중현, 오강훈, 전수열",
                     level: "초",
                     time: "16:00 - 16:50")
    ]
    
    static let workshop: [ProtoSession] = [
        ProtoSession(title: "실용적인 Swift 함수용 프로그래밍",
                     speaker: "최완복",
                     level: "중",
                     time: "13:00 - 14:50"),
        ProtoSession(title: "스위프트 클린코드 + 클린아키텍쳐",
                     speaker: "김정",
                     level: "중",
                     time: "15:00 - 16:50")
    ]
    
    static let dummy = ProtoSession(title: "실용적인 Swift 함수용 프로그래밍",
                                    speaker: "최완복",
                                    level: "중",
                                    time: "13:00 - 14:50")
}
