//
//  Session+SampleData.swift
//  LetSwift
//
//  Created by 박진서 on 8/30/24.
//

import Foundation

extension Session {
    static let sampleData: [Session] = [
        Session(id: 1, title: "SwiftUI의 최신 기능", track: "A", speakers: [Speaker.sampleData[0], Speaker.sampleData[1]], startTime: Date().addingTimeInterval(0), endTime: Date().addingTimeInterval(3600)),
        Session(id: 2, title: "Swift Concurrency 실전 적용", track: "B", speakers: [Speaker.sampleData[1]], startTime: Date().addingTimeInterval(3600), endTime: Date().addingTimeInterval(9000)),
        Session(id: 3, title: "iOS 성능 최적화 전략", track: "A", speakers: [Speaker.sampleData[2]], startTime: Date().addingTimeInterval(9000), endTime: Date().addingTimeInterval(12600)),
        Session(id: 4, title: "Swift Package Manager 심화", track: "B", speakers: [Speaker.sampleData[3]], startTime: Date().addingTimeInterval(12600), endTime: Date().addingTimeInterval(18000)),
        Session(id: 5, title: "SwiftUI와 UIKit 통합하기", track: "A", speakers: [Speaker.sampleData[4]], startTime: Date().addingTimeInterval(18000), endTime: Date().addingTimeInterval(21600)),
        Session(id: 6, title: "Core ML을 이용한 iOS 앱 개발", track: "B", speakers: [Speaker.sampleData[5]], startTime: Date().addingTimeInterval(21600), endTime: Date().addingTimeInterval(27000)),
        Session(id: 7, title: "Swift 디자인 패턴", track: "A", speakers: [Speaker.sampleData[6]], startTime: Date().addingTimeInterval(27000), endTime: Date().addingTimeInterval(30600)),
        Session(id: 8, title: "iOS 테스팅 전략", track: "B", speakers: [Speaker.sampleData[7]], startTime: Date().addingTimeInterval(30600), endTime: Date().addingTimeInterval(36000)),
        Session(id: 9, title: "Swift와 서버 사이드 개발", track: "A", speakers: [Speaker.sampleData[8]], startTime: Date().addingTimeInterval(36000), endTime: Date().addingTimeInterval(39600)),
        Session(id: 10, title: "iOS 앱 보안", track: "B", speakers: [Speaker.sampleData[9]], startTime: Date().addingTimeInterval(39600), endTime: Date().addingTimeInterval(45000)),
        Session(id: 11, title: "SwiftUI 애니메이션 마스터하기", track: "A", speakers: [Speaker.sampleData[10]], startTime: Date().addingTimeInterval(45000), endTime: Date().addingTimeInterval(48600)),
        Session(id: 12, title: "iOS 앱 국제화 및 현지화", track: "B", speakers: [Speaker.sampleData[11]], startTime: Date().addingTimeInterval(48600), endTime: Date().addingTimeInterval(54000)),
        Session(id: 13, title: "Swift 메모리 관리", track: "A", speakers: [Speaker.sampleData[12]], startTime: Date().addingTimeInterval(54000), endTime: Date().addingTimeInterval(57600)),
        Session(id: 14, title: "ARKit를 이용한 증강 현실 앱 개발", track: "B", speakers: [Speaker.sampleData[13]], startTime: Date().addingTimeInterval(57600), endTime: Date().addingTimeInterval(63000)),
        Session(id: 15, title: "Swift 프로토콜 지향 프로그래밍", track: "A", speakers: [Speaker.sampleData[14]], startTime: Date().addingTimeInterval(63000), endTime: Date().addingTimeInterval(66600)),
        Session(id: 16, title: "iOS 앱 출시 전략", track: "B", speakers: [Speaker.sampleData[15]], startTime: Date().addingTimeInterval(66600), endTime: Date().addingTimeInterval(72000)),
        Session(id: 17, title: "Swift 함수형 프로그래밍", track: "A", speakers: [Speaker.sampleData[16]], startTime: Date().addingTimeInterval(72000), endTime: Date().addingTimeInterval(75600)),
        Session(id: 18, title: "iOS 앱 접근성 향상", track: "B", speakers: [Speaker.sampleData[17]], startTime: Date().addingTimeInterval(75600), endTime: Date().addingTimeInterval(81000)),
        Session(id: 19, title: "Swift 메타프로그래밍", track: "A", speakers: [Speaker.sampleData[13]], startTime: Date().addingTimeInterval(81000), endTime: Date().addingTimeInterval(84600)),
        Session(id: 20, title: "iOS 앱 아키텍처 패턴", track: "B", speakers: [Speaker.sampleData[10]], startTime: Date().addingTimeInterval(84600), endTime: Date().addingTimeInterval(90000)),
    ]
}


extension Session.Speaker {
    static let sampleData: [Session.Speaker] = [
        Session.Speaker(name: "김서연", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "이준호", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "박민지", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "최동훈", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "정유진", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "강현우", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "송아영", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "황재현", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "임수진", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "오태훈", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "유하은", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "신동민", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "한지원", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "문승현", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "조윤서", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "권태영", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "백서윤", profileImage: "https://via.placeholder.com/150"),
        Session.Speaker(name: "남기훈", profileImage: "https://via.placeholder.com/150")
    ]
}

