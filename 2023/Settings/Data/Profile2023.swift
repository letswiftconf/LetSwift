//
//  Profile2023.swift
//  LetSwift
//
//  Created by Hani on 2023/09/15.
//

import Foundation

struct Profile2023: Hashable, Identifiable, Equatable {
    enum Role: String, Hashable, Equatable, CaseIterable {
        case Speaker
        case Organizer
    }
    static func == (lhs: Profile2023, rhs: Profile2023) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: UUID = UUID()
    let name: String
    let imageName: String
    let role: Role
    let description: String
    let sns: String?

    init(name: String, imageName: String, role: Role, description: String, sns: String? = nil) {
        self.name = name
        self.imageName = imageName
        self.role = role
        self.description = description
        self.sns = sns
    }
    
    static let organizers: [Profile2023] = [
        .init(name: "아틀라스", imageName: "at", role: .Organizer, description: "‘우리’를 위해 노력하며 성장하기 위한 소통법을 만들어가고 있어요 😊", sns: "https://www.instagram.com/reel/Cq7j5ycrG9e/?igshid=MzRlODBiNWFlZA=="),
        
        .init(name: "리이오", imageName: "leeo", role: .Organizer, description: "누구나 iOS에 입문하기 좋은 세상을 만들고 있는 개발자리 유투버 입니다!"),
        
        .init(name: "홍승현(Noah)", imageName: "noah", role: .Organizer, description: "안녕하세요 Noah입니다 :) 즐거운 커뮤니티 함께 만들어가요!", sns: "https://github.com/noah0316"),
        
        .init(name: "김두리(두리)", imageName: "duri", role: .Organizer, description: "두리두리한 세상을 살아가는 ios 개발자 김두리입니다. 유쾌하게 개발하며 지내고 있어요. 다들 하윙?"),
        
        .init(name: "황지희(Jee.e)", imageName: "jeehee", role: .Organizer, description: "빠른 길보다 바른 길을 가는, 호기심 가득한 iOS 디발자입니다 :D"),
        
        .init(name: "김남수(에네스)", imageName: "ns", role: .Organizer, description: "제 이름 약자는 NS이에요 iOS개발자가 된건 운명이였나봐요 😆"),
        
        .init(name: "안상훈(szzang, 상짱)", imageName: "szzang", role: .Organizer, description: "수다떨기 좋아하는 iOS 개발자", sns: "https://github.com/szzang-kr"),
        
        .init(name: "장진호", imageName: "jinho", role: .Organizer, description: "“대충 흑백사진에 글쓰면 명언같다”", sns: "https://www.linkedin.com/in/jinho-jang-620085117/"),
        
        .init(name: "안상희(셀리나)", imageName: "sanghee", role: .Organizer, description: "음악을 사랑하는 개발자"),
        
        .init(name: "김태완(애셔)", imageName: "asher", role: .Organizer, description: "추리를 좋아하는 개발자"),
        
        .init(name: "최진욱", imageName: "jinwook", role: .Organizer, description: "디지털 노마드가 되기 위해서 으쌰으쌰💪🏻"),
        
        .init(name: "하늘이", imageName: "neuli", role: .Organizer, description: "길을 찾고있어요! 🙈", sns: "https://github.com/NEULiee"),
        
        .init(name: "김태균", imageName: "taeguun", role: .Organizer, description: "하고 싶은 일 모두 할 수 있음 좋겠네 😝"),
        
        .init(name: "이하원(하니)", imageName: "hani", role: .Organizer, description: "☺️"),
        
        .init(name: "허지인(지니)", imageName: "jeein", role: .Organizer, description: "그냥 합니다 뭐든 🥹", sns: "https://www.linkedin.com/in/jiin-heo-672177227/"),
        
        .init(name: "이동헌", imageName: "dongheon", role: .Organizer, description: "즐거운 개발 문화를 만들어 나가고 싶어요!"),
        
        .init(name: "최예주(체즈)", imageName: "chez", role: .Organizer, description: "언녕하세요 iOS 개발자 체즈입니다.. "),
        
        .init(name: "강경훈(강경)", imageName: "kangkyung", role: .Organizer, description: "러닝과 고양이를 사랑합니다😻", sns: "https://www.instagram.com/kangkyung.os/"),
        
        .init(name: "박경민", imageName: "gyungmin", role: .Organizer, description: "재밌는 게 좋아요"),
        
        .init(name: "귤", imageName: "gul", role: .Organizer, description: "❄️"),
        
        .init(name: "hoju", imageName: "hoju", role: .Organizer, description: "종교는 cat holic 입니다 🐈‍⬛🐾"),
    ]
    
    static let speakers: [Profile2023] = [
        .init(name: "김성종", imageName: "kimsungjong", role: .Speaker, description: "새로운 기술을 익히고 떠드는걸 좋아하는 따뜻한 iOS 개발자입니다.", sns: "https://www.linkedin.com/in/sung-jong-will-kim-547348153/"),
        
        .init(name: "방현석", imageName: "banghyunseok", role: .Speaker, description: "정신 꽉 잡아!! 기획서가 또 바뀔거야!! 서바이벌 iOS개발자 긱코드입니다.", sns: "https://github.com/isGeekCode/"),
    
        .init(name: "안정민", imageName: "jung-min", role: .Speaker, description: "은행원입니다."),
    
        .init(name: "고드름", imageName: "JK", role: .Speaker, description: "스위프트 뒤에서 몰래 함께한 혼혈왕자 오브젝티브-C처럼 레츠스위프트 그 시작을 함께했던 교육 개발자입니다", sns: "https://medium.com/@jungkim"),
    
        .init(name: "권문범", imageName: "KwonMunbum", role: .Speaker, description: "유엔젤 - 위메프를 거쳐 네이버, 쿠팡까지 교육, 커머스, 메신저, 검색 등 다양한 앱 개발 경험을 가진 iOS 개발자!! 공부, 입사, 성장 등에 걸친 경험에 대해 얘기하길 좋아합니다.", sns: "https://www.linkedin.com/in/mbkwon/"),
    
        .init(name: "허원", imageName: "HeoWon", role: .Speaker, description: "유연한 서비스를 만드는데 관심이 많은 iOS 개발자입니다.", sns: "https://github.com/heoblitz"),
    
        .init(name: "리이오", imageName: "leeo", role: .Speaker, description: "현업과 상관없는 개발에 관심이 많아요.", sns: "https://www.linkedin.com/in/hyunholee0705/"),
    
        .init(name: "노경섭", imageName: "NohGyungsub", role: .Speaker, description: "코드 속에 사용자 편의를 담는다는 신념으로, 사용자 경험을 위해 끊임없이 노력하는 개발자입니다.", sns: "https://github.com/jasudev"),
    
        .init(name: "안솔찬", imageName: "AnhSolchan", role: .Speaker, description: "오래오래 일하게 해주세요", sns: "https://www.linkedin.com/in/solchan/"),
    
        .init(name: "이승준", imageName: "leeseungjun", role: .Speaker, description: "내가 `print()`를 들여다볼 때, `print()`도 나를 들여다보는 철학과 출신 iOS 개발자 입니다.", sns: "https://github.com/valselee"),
    
        .init(name: "Jihoon", imageName: "AnhJihoon", role: .Speaker, description: "다양한 방식의 접근을 좋아하는 iOS 개발자입니다", sns: "https://github.com/Jihoonahn"),
    
        .init(name: "김우성", imageName: "KimWooseong", role: .Speaker, description: "29CM의 모바일팀 리드를 맡고 있습니다. 도구 메이커 성향이 강해서, 팀 구성원의 업무를 좀 더 편하게 만들어줄 수 있는 스크립트를 이것저것 만들곤 합니다.", sns: "https://www.linkedin.com/in/wooseong-kim/"),
    
        .init(name: "허성진", imageName: "heoseongjin", role: .Speaker, description: "복잡한 문제를 심플하고 유쾌하게 풀어내는 것을 좋아합니다. 그래서 개발과 클라이밍을 좋아합니다.", sns: "https://github.com/heoseongjin"),
    
        .init(name: "곰튀김", imageName: "Gom", role: .Speaker, description: "리얼리즘 프로그래머", sns: "https://github.com/iamchiwon"),
    
        .init(name: "라이노", imageName: "lino", role: .Speaker, description: "코드가 가진 가능성을 탐구하는 것을 좋아합니다.", sns: "https://www.linkedin.com/in/soohwan-cho-60468a19b/"),
    ]
}
