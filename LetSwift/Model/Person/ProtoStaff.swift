//
//  ProtoStaff.swift
//  LetSwift
//
//  Created by kor45cw on 2019/10/14.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation

class ProtoStaff: SuperPerson {
    init(name: String, organization: String = "", tags: [String] = [], description: String) {
        super.init(name: name, organization: organization, description: description, tags: tags)
    }
}

extension ProtoStaff {
    static func makeProtoData() -> [ProtoStaff] {
        return [ProtoStaff(name: "김정",
                           organization: "코드스쿼드",
                           tags: [],
                           description: "달콤한 스위프트와 후덕한 오브젝티브-C의 혼혈왕자"),
                ProtoStaff(name: "김은영",
                           organization: "GMO Pepabo, Inc.",
                           tags: ["디자인담당", "웹개발"],
                           description: "일본에서 일하고 있어요 !\n본업은 iOS 개발이지요 🐣 @unnnyong"),
                ProtoStaff(name: "구범모",
                           organization: "고려대학교",
                           tags: ["앱개발", "카메라맨"],
                           description: "사진 찍는 iOS 개발자입니다 🤗"),
                ProtoStaff(name: "김나용",
                           organization: "한양대학교",
                           tags: ["앱개발"],
                           description: "🥚🐣🐥\n성장 중인 개발자, 김나용 입니다."),
                ProtoStaff(name: "김형중",
                           organization: "NAVER",
                           tags: ["앱개발"],
                           description: "안녕하세요, 김형중입니다."),
                ProtoStaff(name: "손창우",
                           organization: "한국카카오은행",
                           tags: ["앱개발"],
                           description: "MDD (Money Driven Development)"),
                ProtoStaff(name: "강준영",
                           organization: "(주)엘오이코리아",
                           description: "💻 Backend Developer"),
                ProtoStaff(name: "구민회",
                           organization: "텐핑거스",
                           description: "텐핑거스에서 Datepop iOS App을 개발하고 있습니다. 반가와요 ^^"),
                ProtoStaff(name: "구본성",
                           organization: "PJ FACTORY",
                           description: "노력하는 개발자에서, 잘하는 개발자로 인생 디버깅중"),
                ProtoStaff(name: "권재욱",
                           organization: "퍼즐벤처스",
                           description: "먹는 거 좋아하는 개발자"),
                ProtoStaff(name: "김근영",
                           organization: "KxCoding",
                           description: "강의하면서 앱 만드는 개발자입니다 :)"),
                ProtoStaff(name: "김주희",
                           organization: "네이버",
                           description: "인싸를 꿈꾸는 아싸 개발자입니다. 친한 척 해주시면 감사합니다 ;)"),
                ProtoStaff(name: "노수진",
                           organization: "네이버웹툰",
                           description: "누구나 올 수 있고 모두가 즐거운 컨퍼런스가 됐으면 좋겠습니다!"),
                ProtoStaff(name: "문영선",
                           organization: "쏘카",
                           description: "호기심 많고 즐거움을 공유하고픈 iOS 개발자 입니다."),
                ProtoStaff(name: "손지민",
                           organization: "선린인터넷고등학교",
                           description: "세상을 변화시키고 싶은 고등학생입니다!"),
                ProtoStaff(name: "오영택",
                           organization: "(주)힐링페이퍼",
                           description: "오늘만 사는 개발자. 강남언니 iOS앱을 개발하고 있어요."),
                ProtoStaff(name: "이동영",
                           description: "사과는 맛있어 "),
                ProtoStaff(name: "이동진",
                           organization: "NBT",
                           description: "재미있게 함께 같이해요! 많이 알려주세요"),
                ProtoStaff(name: "이재은",
                           description: "☁️구름 좋아하는 개발자, Pilvi입니다."),
                ProtoStaff(name: "이태현(Jake)",
                           organization: "야놀자",
                           description: "호기심 많은 개발자이자 유투브 꿈나무 제이크 입니다 :)"),
                ProtoStaff(name: "조민지",
                           description: "😎😎😎"),]
    }
}
