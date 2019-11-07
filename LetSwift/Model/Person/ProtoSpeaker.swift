//
//  ProtoSpeaker.swift
//  LetSwift
//
//  Created by 김나용 on 14/10/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

class ProtoSpeaker: SuperPerson {
    let sessions: [String] // TODO: [Session]
    
    init(imageName: String, name: String, organization: String, sessions: [String], description: String = "", subDescription: String = ""){
        self.sessions = sessions
        let tags = subDescription
            .trimmingCharacters(in: .whitespaces)
            .split(separator: "#").map { String($0) }
        
        super.init(name: name, imageName: imageName, organization: organization, description: description, tags: tags)
    }
}

extension ProtoSpeaker {
    static let speakers: [ProtoSpeaker] = [
        ProtoSpeaker(imageName: "김정_S",
                     name: "김정",
                     organization: "코드스쿼드",
                     sessions: [
                        "👨‍🏫 키노트 + 컨퍼런스를 즐기는 방법",
                        "👨‍💻 스위프트 프로그래밍 코드 리뷰"
            ],
                     description: "달콤한 스위프트와 후덕한 오브젝티브-C의 혼혈왕자",
                     subDescription: ""),
        ProtoSpeaker(imageName: "박보영",
                     name: "박보영",
                     organization: "뱅크샐러드",
                     sessions: ["👨‍🏫 RxSwift to Combine (feat. SwiftUI)"],
                     description: "뱅크샐러드 iOS application 개발자입니다.\n여기저기서 이런저런일 하다가 서른 넘어 프로그래밍 세계에 발을 첫 발을 내딛었습니다. ",
                     subDescription: "#RxSwift #Combine #iPhonePro갖고십따"),
        ProtoSpeaker(imageName: "백성욱",
                     name: "백성욱",
                     organization: "LINE BIZPLUS",
                     sessions: ["👨‍🏫 Behind Scene of Delightful Experience"],
                     description: "여행과 커피를 좋아하는 iOS 개발자입니다.",
                     subDescription: ""),
        ProtoSpeaker(imageName: "강승철",
                     name: "강승철",
                     organization: "야놀자",
                     sessions: ["👨‍🏫 미려한 UI/UX를 위한 여정"],
                     description: "야놀자에서 iOS 리딩을 하고 있습니다. OOP와 FP에 심취해 있습니다.",
                     subDescription: "#CADisplayLink #animation #순차처리"),
        ProtoSpeaker(imageName: "안정민",
                     name: "안정민",
                     organization: "한국카카오은행",
                     sessions: ["👨‍🏫 MVC, MVVM, ReactorKit, Viper를 거쳐 RIB 정착기"],
                     description: "소소하게 제과를 취미로 하고 있고, 자그만한 iOS 블로그를 운영하는 은행원입니다.",
                     subDescription: "#MVC #MVVM #ReactorKit #VIPER #RIBs"),
        ProtoSpeaker(imageName: "김용성",
                     name: "김용성",
                     organization: "VCNC",
                     sessions: ["🍵 스타트업 개발자(주니어의 성장, 서비스, 개발 문화)"],
                     description: "VCNC 에서 모바일 어플리케이션을 개발하고 있습니다.",
                     subDescription: ""),
        ProtoSpeaker(imageName: "김건우",
                     name: "김건우",
                     organization: "VCNC",
                     sessions: ["🍵 스타트업 개발자(주니어의 성장, 서비스, 개발 문화)"],
                     description: "VCNC에서 타다의 iOS와 안드로이드 개발을 하고 있는 김건우입니다.\n사용자의 경험을 깊이 고민하는 데 관심이 많습니다.",
                     subDescription: ""),
        ProtoSpeaker(imageName: "장왕수",
                     name: "장왕수",
                     organization: "아파트너",
                     sessions: ["🍵 iOS 프리랜서 생활"],
                     description: "수다스러운 개발자입니다. \n함께 개발 이야기가 하고 싶어요.",
                     subDescription: "#Freelance #Swift #Objc"),
        ProtoSpeaker(imageName: "최완복",
                     name: "최완복",
                     organization: "LINE Biz Plus",
                     sessions: ["👨‍💻 실용적인 Swift 함수형 프로그래밍"],
                     description: "LINE Pay iOS 앱을 개발하고 있습니다.\n저지르고 수습하며 살고 있습니다.",
                     subDescription: "#Practical #FuntionalProgramming"),
        ProtoSpeaker(imageName: "이봉원",
                     name: "이봉원",
                     organization: "패스트캠퍼스",
                     sessions: ["👨‍🏫 Swift in SwiftUI"],
                     description: "SwiftUI에 반영된 Swift 5.1의 주요 구현사항에 대해 소개합니다.",
                     subDescription: "#Swift #SwiftUI"),
        ProtoSpeaker(imageName: "김남현",
                     name: "김남현",
                     organization: "VCNC",
                     sessions: ["👨‍🏫 Xcode Previews - IB없이 개발하기"],
                     description: "MFC로 개발에 입문하여 VCNC 창업 때부터 비트윈, 타다 클라이언트를 만들면서 수년간 모바일 개발을 담당하고 있습니다. \n이를 바탕으로 사용자 UI 프로그래밍을 관통하는 \"무언가\"를 찾고자 하는 개발자입니다.",
                     subDescription: "#XcodePreviews"),
        ProtoSpeaker(imageName: "황규영",
                     name: "황규영",
                     organization: "SendBird",
                     sessions: ["🍵 개발자와의 심리전 - SDK 개발"],
                     description: "창업과 함께 앱 개발을 시작해서 B2B SDK 개발을 하는 엔지니어",
                     subDescription: "#SDK #개발자를_위한_개발자 #심리전 #역지사지"),
        ProtoSpeaker(imageName: "이규원",
                      name: "이규원",
                      organization: "카카오페이지",
                      sessions: ["🍵 주니어 개발자의 성장하는 글쓰기"],
                      description: "카카오페이지에서 어느덧 3년째 iOS 개발자로 일하고 있습니다. \n무엇인가 쓰는 것을 좋아합니다!",
                      subDescription: "#주니어 #성장 #개발자글쓰기 #사내블로그 #깃헙 #슬랙 #회사일기"),
        ProtoSpeaker(imageName: "이병찬",
                      name: "이병찬",
                      organization: "뱅크샐러드",
                      sessions: ["👨‍🏫 RxTesting 같이 시작하기"],
                      description: "안녕하세요 뱅크샐러드 iOS앱을 개발하고 있는 이병찬입니다. \nRx와 Test코드에 관심이 많으며 대체될 수 있는 코드를 작성하기 위해 노력하는 개발자 입니다.",
                      subDescription: "#Rx #TestCode #뱀장어"),
        ProtoSpeaker(imageName: "곽도영",
                      name: "곽도영",
                      organization: "네이버",
                      sessions: ["👨‍🏫 iOS 앱에서 머신러닝이 해결할 수 있는 문제들"],
                      description: "재미 붙이면 오래합니다.",
                      subDescription: "#Mobile❤️ML #CoreML #TFLite"),
        ProtoSpeaker(imageName: "이정우",
                      name: "이정우",
                      organization: "IBM Japan",
                      sessions: ["👨‍🏫 코드로 iOS UI 편하게 작업하기 위한 라이브러리 작업"],
                      description: "#NoStoryboard",
                      subDescription: ""),
        ProtoSpeaker(imageName: "권문범",
                      name: "권문범",
                      organization: "네이버",
                      sessions: ["🍵 여러 회사 개발 문화와 커뮤니케이션"],
                      description: "유엔젤 - 위메프를 거쳐 네이버까지 교육/커머스/메신저/검색 등 다양한 앱 개발 경험을 가진 iOS 개발자",
                      subDescription: "#iOS #Developer #Networking #Study #Career"),
        ProtoSpeaker(imageName: "우경재",
                      name: "우경재",
                      organization: "쏘카",
                      sessions: ["🍵 쏘카의 개발 문화"],
                      description: "쏘카에서 모바일 클라이언트 팀을 꾸리고 있습니다. \niOS 개발도 계속 합니다.",
                      subDescription: "#개발문화"),
        ProtoSpeaker(imageName: "조성현",
                      name: "조성현",
                      organization: "민족사관고등학교",
                      sessions: ["🍵 공짜로 WWDC 가는법(스칼라십)"],
                      description: "저도 인턴 좀 하고 싶어요",
                      subDescription: "#wwdcscholars"),
        ProtoSpeaker(imageName: "이재성",
                      name: "이재성",
                      organization: "SendBird",
                      sessions: ["🍵 공짜로 WWDC 가는법(스칼라십)"],
                      description: "안녕하세요. 이재성입니다.",
                      subDescription: "#wwdcscholars"),
        ProtoSpeaker(imageName: "김민혁",
                      name: "김민혁",
                      organization: "SendBird",
                      sessions: ["🍵 공짜로 WWDC 가는법(스칼라십)"],
                      description: "고딩이코딩",
                      subDescription: "#wwdcscholars"),
        ProtoSpeaker(imageName: "김우성",
                      name: "김우성",
                      organization: "StyleShare Inc.",
                      sessions: ["🍵 스타일쉐어 iOS팀 개발 문화"],
                      description: "‘제품을 깎는 장인’을 목표로 합니다. \n팀과 회사가 계속 더 잘 되는 것에 관심이 많습니다.",
                      subDescription: "#팀문화 #협업")
    ]
    
    static let dummy: ProtoSpeaker =  ProtoSpeaker(imageName: "김정_S",
                                                   name: "김정",
                                                   organization: "코드스쿼드",
                                                   sessions: [
                                                    "👨‍🏫 키노트 + 컨퍼런스를 즐기는 방법",
                                                    "👨‍💻 스위프트 프로그래밍 코드 리뷰"
        ],
                                                   description: "달콤한 스위프트와 후덕한 오브젝티브-C의 혼혈왕자",
                                                   subDescription: "")
}
