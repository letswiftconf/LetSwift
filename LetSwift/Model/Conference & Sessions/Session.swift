//
//  Session.swift
//  LetSwift
//
//  Created by BumMo Koo on 28/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

// MARK: - Session
/// A session represents a presentation by a `Speaker`.
class Session: Schedulable, Identifiable, Codable, ObservableObject {
    let id = UUID()
    var title: String { willSet { objectWillChange.send() } }
    var description: String { willSet { objectWillChange.send() } }
    var speaker: Participant { willSet { objectWillChange.send() } }
    var location: String { willSet { objectWillChange.send() } }
    var timespan: DateInterval { willSet { objectWillChange.send() } }
    var track: Session.Track { willSet { objectWillChange.send() } }
    var video: Video? { willSet { objectWillChange.send() } }
    
    // MARK: - Initialization
    init(title: String,
         description: String,
         speaker: Participant,
         location: String,
         timespan: DateInterval,
         track: Session.Track,
         video: Video?) {
        self.title = title
        self.description = description
        self.speaker = speaker
        self.location = location
        self.timespan = timespan
        self.track = track
        self.video = video
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case id, title, description, speaker, location, timespan, track, video
    }
    
    // MARK: - Observable Object
    let objectWillChange = ObservableObjectPublisher()
}

// MARK: - Equatable & Hashable
extension Session: Hashable {
    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Track
extension Session {
    /// Track type of a `Session`. e.g. A session can be either `.session` track or `.workshop` track.
    enum Track: String, Identifiable, Codable, CaseIterable {
        case unspecified
        case session
        case workshop
        
        var id: String {
            return rawValue
        }
        
        var localizedName: String {
            switch self {
            case .unspecified: return "Unspecified"
            case .session: return "Session"
            case .workshop: return "Workshop"
            }
        }
    }
}

// MARK - Dummy
extension Session {
    static var dummy: Session {
        return Session(title: "Untitled",
                       description: "",
                       speaker: Participant.dummy,
                       location: "Unknown Location",
                       timespan: DateInterval(),
                       track: .unspecified,
                       video: nil)
    }
}


extension Session {
    
    static var sessionsFrom2018: [Session] {
        return [
            Self.templateSession(title: "키노트",
                                 profile: Profile(familyName: "김", givenName: "정"),
                                 video: Video(url: URL(string: "https://youtu.be/xZ5IywL9Zkg")!,
                                              length: 20 * 60.0)),
            Self.templateSession(title: "사이드 프로젝트로 앱스토어 1위 공략해보기",
                                 profile: Profile(familyName: "노", givenName: "수진"),
                                 video: Video(url: URL(string: "https://youtu.be/_2t24zQvRFs")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "iOS💖Ruby",
                                 profile: Profile(familyName: "김", givenName: "은영"),
                                 video: Video(url: URL(string: "https://youtu.be/BDuVrhfnsnE")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "TDS (Toss Design System) v2 소개",
                                 profile: Profile(familyName: "이", givenName: "택규"),
                                 video: Video(url: URL(string: "https://youtu.be/fWdXnLERm8E")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "RxRIBs, Multiplatform architecture with Rx",
                                 profile: Profile(familyName: "김", givenName: "남현"),
                                 video: Video(url: URL(string: "https://youtu.be/BvPW-cd8mpw")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "ReactorKit으로 RxSwift 시작하기",
                                 profile: Profile(familyName: "김", givenName: "태준"),
                                 video: Video(url: URL(string: "https://youtu.be/G1b1sBy8XBA")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "ReSwift와 함께 Unidirectional Architecture",
                                 profile: Profile(familyName: "황", givenName: "재욱"),
                                 video: Video(url: URL(string: "https://youtu.be/ypI9VP0Q48k")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "RxSwift Internal",
                                 profile: Profile(familyName: "오", givenName: "진성"),
                                 video: Video(url: URL(string: "https://youtu.be/DsE-sagI04A")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "GraphQL over Rest API",
                                 profile: Profile(familyName: "이", givenName: "봉원"),
                                 video: Video(url: URL(string: "https://youtu.be/4JW8kku0V5I")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "SIMD & MPS in Swift",
                                 profile: Profile(familyName: "양", givenName: "승헌"),
                                 video: Video(url: URL(string: "https://youtu.be/S5tJi4KCItI")!,
                                              length: 30 * 60.0))
        ]
    }
    
    static var sessionsFrom2017: [Session] {
        return [
            Self.templateSession(title: "키노트",
                                 profile: Profile(familyName: "김", givenName: "정"),
                                 video: Video(url: URL(string: "https://youtu.be/pPcijkdS6TY")!,
                                              length: 20 * 60.0)),
            Self.templateSession(title: "What's New Swift 4",
                                 profile: Profile(familyName: "김", givenName: "영후"),
                                 video: Video(url: URL(string: "https://youtu.be/uIqP4SmSFww")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "Swift vs. Kotlin",
                                 profile: Profile(familyName: "유", givenName: "용하"),
                                 video: Video(url: URL(string: "https://youtu.be/1wmn97Csi9g")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "Concurrency in Swift",
                                 profile: Profile(familyName: "허", givenName: "혁"),
                                 video: Video(url: URL(string: "https://youtu.be/0yj6ftn1Nzw")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "Metal기반 특별한 UI/UX 제공하기",
                                 profile: Profile(familyName: "이", givenName: "선협"),
                                 video: Video(url: URL(string: "https://youtu.be/mB9d5RDNryw")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "iOS 11 ARKit 시작하기",
                                 profile: Profile(familyName: "이", givenName: "봉원"),
                                 video: Video(url: URL(string: "https://youtu.be/ODQE1u8S8_8")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "토스의 개발/배포 환경",
                                 profile: Profile(familyName: "손", givenName: "민탁"),
                                 video: Video(url: URL(string: "https://youtu.be/338FdLzGhhY")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "Serverless vs. Server-side Swift",
                                 profile: Profile(familyName: "Lee", givenName: "Bob"),
                                 video: Video(url: URL(string: "https://youtu.be/3eneYtXdmR4")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "RxSwift 활용하기",
                                 profile: Profile(familyName: "최", givenName: "완복"),
                                 video: Video(url: URL(string: "https://youtu.be/WN6s3xWZ3tw")!,
                                              length: 30 * 60.0)),
            Self.templateSession(title: "ReactorKit으로 단방향 반응형 앱 만들기",
                                 profile: Profile(familyName: "전", givenName: "수열"),
                                 video: Video(url: URL(string: "https://youtu.be/ASwBnMJNUK4")!,
                                              length: 30 * 60.0))
        ]
    }
    
    static var sessionsFrom2016: [Session] {
        return [
            Self.templateSession(title: "스위프트 3 소개",
                                 profile: Profile(familyName: "박", givenName: "세현"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/letswift-swift-3-0/")!,
                                              length: 25 * 60.0)),
            Self.templateSession(title: "스위프트 개발환경의 변화",
                                 profile: Profile(familyName: "허", givenName: "혁"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/swift-tools-xcode-lldb-instrument/")!,
                                              length: 40 * 60.0)),
            Self.templateSession(title: "Do Swift: 스위프트 프로젝트 도전기",
                                 profile: Profile(familyName: "김", givenName: "윤봉"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/letswift-do-swift/")!,
                                              length: 25 * 60.0)),
            Self.templateSession(title: "스위프트 Internals",
                                 profile: Profile(familyName: "김", givenName: "정"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/swift-internals-llvm-type-system-swift-foundation/")!,
                                              length: 45 * 60.0)),
            Self.templateSession(title: "안드로이드 개발자를 위한 스위프트",
                                 profile: Profile(familyName: "유", givenName: "병한"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/swift-viper/")!,
                                              length: 25 * 60.0)),
            Self.templateSession(title: "RxSwift 시작하기",
                                 profile: Profile(familyName: "최", givenName: "완복"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/letswift-rxswift/")!,
                                              length: 40 * 60.0)),
            Self.templateSession(title: "스위프트 패키지 매니저",
                                 profile: Profile(familyName: "윤", givenName: "성관"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/swift-package-manager/")!,
                                              length: 25 * 60.0)),
            Self.templateSession(title: "프로토콜 오리엔티드 프로그래밍",
                                 profile: Profile(familyName: "조", givenName: "성규"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/protocol-oriented-programming-in-swift/")!,
                                              length: 40 * 60.0)),
            Self.templateSession(title: "스위프트 퍼포먼스 이해하기",
                                 profile: Profile(familyName: "유", givenName: "용하"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/letswift-swift-performance/")!,
                                              length: 40 * 60.0)),
            Self.templateSession(title: "Docker + 스위프트 서버 사이드",
                                 profile: Profile(familyName: "안", givenName: "병욱"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/letswift-swift-server-side/")!,
                                              length: 25 * 60.0)),
            Self.templateSession(title: "Swift 모바일데이터베이스 : Realm",
                                 profile: Profile(familyName: "박", givenName: "민우"),
                                 video: Video(url: URL(string: "https://academy.realm.io/kr/posts/realm-swift-mobile-database/")!,
                                              length: 15 * 60.0))
        ]
    }
    
    private static func templateSession(title: String, profile: Profile, video: Video) -> Session {
        return Session(
            title: title,
            description: "",
            speaker: Participant(profile: profile,
                                 role: .unspecified,
                                 description: "",
                                 imageURLString: "",
                                 socialAccounts: []),
            location: "",
            timespan: DateInterval(),
            track: .unspecified,
            video: video
        )
    }
    
}
