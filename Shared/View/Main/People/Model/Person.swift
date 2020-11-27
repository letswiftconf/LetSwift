//
//  Person.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/23.
//

import Foundation

struct Person: Hashable, Identifiable, Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: UUID = UUID()
    let imageName: String
    let name: String
    let organization: String?
    let role: [PersonRole]
    let description: String
    let sns: [SNS]
    
    init(name: String, organization: String, role: [PersonRole], description: String, sns: [SNS]) {
        self.name = name
        self.imageName = "2020_\(name)"
        self.organization = organization
        self.role = role
        self.description = description
        self.sns = sns
    }
}

enum PersonRole: Hashable {
    case devApp
    case staff
    case planner
    case sponsor
    case organizer
    
    var localizedString: String {
        switch self {
        case .devApp:
            return "앱 개발"
        case .organizer:
            return "Organizer"
        case .planner:
            return "행사 기획"
        case .sponsor:
            return "후원"
        case .staff:
            return "행사 진행"
        }
    }
}

enum SNS: Hashable {
    case email(String)
    case gitHub(String)
    case instagram(String)
    case faceBook(String)
    case twitter(String)
    case blog(String)
    case linkedIn(String)
    
    var localizedString: String {
        switch self {
        case .email(_):
            return "Email"
        case .gitHub(_):
            return "GitHub"
        case .instagram(_):
            return "Instagram"
        case .faceBook(_):
            return "Facebook"
        case .twitter(_):
            return "Twitter"
        case .blog(_):
            return "Blog"
        case .linkedIn(_):
            return "LinkedIn"
        }
    }
    
    var url: URL? {
        switch self {
        case .email(let address):
            return URL(string: "mailto:\(address)")
        case .gitHub(let path), .instagram(let path), .faceBook(let path), .twitter(let path), .blog(let path), .linkedIn(let path):
            return URL(string: path)
        }
    }
}

enum PersonType {
    case organizer
    case panels
    case staff
}

extension Person {
    static func makeOrganizer() -> [Person] {
        return [
            Person(name: "김정",
                   organization: "코드스쿼드",
                   role: [.planner, .staff],
                   description: "나의 작은 발자국이 누군가에게 표식으로 남기를",
                   sns: [
                    .email("godrm77@gmail.com"),
                    .gitHub("https://github.com/godrm"),
                    .instagram("https://www.instagram.com/godrm"),
                    .faceBook("https://web.facebook.com/godrm"),
                    .twitter("https://twitter.com/godrm")
                   ])
        ]
    }
    
    static func makePanels() -> [Person] {
        return [Person.makeDummy()]
    }
    
    static func makeStaff() -> [Person] {
        return [
            Person(name: "구범모",
                   organization: "스노우",
                   role: [.staff, .devApp],
                   description: "📸 사진 찍기 좋아하는 개발자입니다!",
                   sns: [
                    .email("ksquareatm@gmail.com"),
                    .gitHub("https://github.com/gbmksquare"),
                    .instagram("https://www.instagram.com/gbmksquare/"),
                    .faceBook("https://www.facebook.com/gbmksquare"),
                    .twitter("http://twitter.com/gbmksquare"),
                    .linkedIn("http://linkedin.com/in/gbmksquare/")
                   ]),
            Person(name: "김성훈",
                   organization: "하이퍼커넥트",
                   role: [.staff],
                   description: "내년엔 우리 오프라인으로 만날수 있겠죠?",
                   sns: [
                    .gitHub("https://github.com/Seonghun23")
                   ]),
            Person(name: "김정",
                   organization: "코드스쿼드",
                   role: [.planner, .staff],
                   description: "나의 작은 발자국이 누군가에게 표식으로 남기를",
                   sns: [
                    .email("godrm77@gmail.com"),
                    .gitHub("https://github.com/godrm"),
                    .instagram("https://www.instagram.com/godrm"),
                    .faceBook("https://web.facebook.com/godrm"),
                    .twitter("https://twitter.com/godrm")
                   ]),
            Person(name: "권순길",
                   organization: "주)에스에이엠티",
                   role: [.sponsor, .staff],
                   description: "그냥 그렇게... 그래서 나도...",
                   sns: [
                    .email("erikcky77@gmail.colm"),
                    .instagram("https://www.instagram.com/ricky_kwon/")
                   ]),
            Person(name: "박채완",
                   organization: "네이버 클라우드",
                   role: [.staff],
                   description: "의미 있는 개발을 하고 싶습니다.",
                   sns: [
                    .email("seizzeday@gmail.com"),
                    .gitHub("https://github.com/seizze"),
                    .blog("https://seizze.github.io")
                   ]),
            Person(name: "송다영",
                   organization: "포스타입",
                   role: [.staff, .devApp],
                   description: "Code makes world better.",
                   sns: [
                    .email("sdy2856@gmail.com"),
                    .gitHub("https://github.com/delmaSong"),
                    .instagram("https://www.instagram.com/thinker_yeong/")
                   ]),
            Person(name: "신한섭",
                   organization: "가천대학교",
                   role: [.staff, .devApp],
                   description: "끊임없이 배우는 iOS 개발자가 되고싶습니다.",
                   sns: [
                    .email("hanseop95@gmail.com"),
                    .gitHub("https://github.com/1Consumption"),
                    .instagram("https://www.instagram.com/1consumption/"),
                    .blog("https://1consumption.github.io")
                   ]),
            Person(name: "염도영",
                   organization: "드라마앤컴퍼니",
                   role: [.staff, .devApp],
                   description: "내일은 오늘보다 더 좋은 사람이고 싶습니다.",
                   sns: [
                    .email("dyyeom@gmail.com"),
                    .gitHub("https://github.com/dyyeom"),
                    .instagram("https://www.instagram.com/dyyeom/"),
                    .faceBook("https://www.facebook.com/dyyeom"),
                    .linkedIn("https://www.linkedin.com/in/dyyeom/")
                   ]),
            Person(name: "유현식",
                   organization: "시어스랩",
                   role: [.staff],
                   description: "코로나 웨않끝나죠?",
                   sns: [
                    .email("dbgustlr92@gmail.com"),
                    .gitHub("https://github.com/Hyunsik-Yoo"),
                    .instagram("https://www.instagram.com/hyun_sik_yoo/")
                   ]),
            Person(name: "이근나",
                   organization: "",
                   role: [.staff],
                   description: "매일 엊그제보다 더 성장하고 있습니다.👍",
                   sns: [
                    .email("keunnalee@gmail.com"),
                    .gitHub("https://github.com/dev-Lena"),
                    .instagram("https://www.instagram.com/dev_lena_lee/"),
                    .blog("https://lena-chamna.netlify.app")
                   ]),
            Person(name: "이현호",
                   organization: "와디즈",
                   role: [.staff],
                   description: "노래하는 개발자입니다.",
                   sns: [
                    .email("mizzking75@gmail.com"),
                    .gitHub("https://github.com/m1zz"),
                    .blog("http://dev200ok.blogspot.com"),
                    .linkedIn("https://www.linkedin.com/in/hyunholee0705/")
                   ]),
            Person(name: "임승혁",
                   organization: "스윗트래커",
                   role: [.staff],
                   description: "매일 매일 기록하기 📖",
                   sns: [
                    .gitHub("https://github.com/Limwin94"),
                    .instagram("https://www.instagram.com/limwin94/")
                   ])
        ]
    }
    
    static func makeDummy() -> Person {
        return Person(name: "신한섭", organization: "", role: [], description: "", sns: [])
    }
}
