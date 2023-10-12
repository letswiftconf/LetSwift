//
//  SessionInformationModel.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

struct SessionInformationModel: Decodable {
    let rowTypeString: String
    let placeTypeString: String
    let startTimeString: String
    let endTimeString: String
    let titleString: String
    let contentString: String
    let speaker: SessionSpeakerModel?

    enum CodingKeys: String, CodingKey {
        case rowTypeString = "rowType"
        case placeTypeString = "place"
        case startTimeString = "startTime"
        case endTimeString = "endTime"
        case titleString = "title"
        case contentString = "content"
        case speaker = "speaker"
    }
}

extension SessionInformationModel {
    struct SessionSpeakerModel: Decodable {
        let nameString: String
        let roleString: String
        let descriptionString: String
        let profileString: String
        let isTeam: Bool

        init(nameString: String, roleString: String, descriptionString: String, profileString: String, isTeam: Bool = false) {
            self.nameString = nameString
            self.roleString = roleString
            self.descriptionString = descriptionString
            self.profileString = profileString
            self.isTeam = isTeam
        }

        enum CodingKeys: String, CodingKey {
            case nameString = "name"
            case roleString = "role"
            case descriptionString = "description"
            case profileString = "profile"
            case isTeam = "is_team"
        }
    }
}

extension SessionInformationModel: Identifiable, Equatable {
    var id: UUID { return UUID() }

    static func == (lhs: SessionInformationModel, rhs: SessionInformationModel) -> Bool {
        // FIXME: fix to id: UUID
        return lhs.titleString == rhs.titleString
    }
}

extension SessionInformationModel {
    static let samples: [SessionInformationModel] = [
        SessionInformationModel(
            rowTypeString: "opening",
            placeTypeString: "bigRoom",
            startTimeString: "10:00",
            endTimeString: "10:20",
            titleString: "오프닝 키노트",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "10:30",
            endTimeString: "11:00",
            titleString: "오픈 소스로서의 Swift 깊게 바라보기: Swift-evolution과 proposal",
            contentString: "",
            speaker: SessionSpeakerModel(
                nameString: "이승준",
                roleString: "OO회사 | 무슨 포지션",
                descriptionString: "내가 `print()`를 들여다볼 때, `print()`도 나를 들여다보는 철학과 출신 iOS 개발자 입니다. 아는 내용을 공유하기를 좋아해요.",
                profileString: "leeseungjun"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "11:10",
            endTimeString: "11:50",
            titleString: "Path of Swift - Swift가 프로그램이 되기까지",
            contentString: "",
            speaker: SessionSpeakerModel(
                nameString: "라이노",
                roleString: "OO회사",
                descriptionString: "코드가 가진 가능성을 탐구하는 것을 좋아합니다.",
                profileString: "lino"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "bigRoom",
            startTimeString: "",
            endTimeString: "",
            titleString: "11:50 ~ 12:40 점심 시간",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "12:40",
            endTimeString: "13:40",
            titleString: "객체가 함수를 만났을 때",
            contentString: "유엔젤 - 위메프를 거쳐 네이버/쿠팡까지 교육/커머스/메신저/검색 등 다양한 앱 개발 경험을 가진 iOS 개발자!! 공부, 입사, 성장 등에 걸친 경험에 대해 얘기하길 좋아합니다.",
            speaker: SessionSpeakerModel(
                nameString: "권문범",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "KwonMunbum"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "13:50",
            endTimeString: "14:30",
            titleString: "SwiftUI, 효율적인 개발 방법과 놀이에 관한 이야기",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "노경섭",
                roleString: "OO회사",
                descriptionString: "코드 속에 사용자 편의를 담는다는 신념으로, 사용자 경험을 위해 끊임없이 노력하는 개발자입니다.",
                profileString: "NohGyungsub"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "14:40",
            endTimeString: "15:20",
            titleString: "스위프트 매크로, 어디다 쓰죠?",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "김성종",
                roleString: "OO회사",
                descriptionString: "새로운 기술을 익히고 떠드는걸 좋아하는 따뜻한 iOS 개발자입니다.",
                profileString: "kimsungjong"
            )
        ),
//        SessionInformationModel(
//            rowTypeString: "hasDetailView",
//            placeTypeString: "bigRoom",
//            startTimeString: "15:10",
//            endTimeString: "15:30",
//            titleString: "잊지마세요 Unwind Segue - 생각보다 Segue는 \"여전히\" 유용합니다.",
//            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
//            speaker: SessionSpeakerModel(
//                nameString: "방현석",
//                roleString: "OO회사",
//                descriptionString: "정신 꽉 잡아!! 기획서가 또 바뀔거야!!\n서바이벌 iOS개발자 긱코드입니다.",
//                profileString: "banghyunseok"
//            )
//        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "15:30",
            endTimeString: "16:10",
            titleString: "Tuist, 도입은 했는데 그래서 Modular Architecture 은 어떻게 만들어가면 되나요?",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "김우성",
                roleString: "OO회사",
                descriptionString: "29CM의 모바일팀 리드를 맡고 있습니다. 도구 메이커 성향이 강해서, 팀 구성원의 업무를 좀 더 편하게 만들어줄 수 있는 스크립트를 이것저것 만들곤 합니다.",
                profileString: "KimWooseong"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "16:20",
            endTimeString: "17:00",
            titleString: "요즘유행하는 AI 나도 해보자 (feat. CoreML)",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "곰튀김",
                roleString: "OO회사",
                descriptionString: "리얼리즘 프로그래머",
                profileString: "Gom"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "bigRoom",
            startTimeString: "",
            endTimeString: "",
            titleString: "17:00 ~ 17:30 클로징 이벤트 및 경품 추천",
            contentString: "",
            speaker: nil
        ),

        //-=-=-=-=-=-=-=-=-===========
        SessionInformationModel(
            rowTypeString: "opening",
            placeTypeString: "smallRoom",
            startTimeString: "10:00",
            endTimeString: "10:20",
            titleString: "오프닝 키노트\n(대회의실 1)",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "10:30",
            endTimeString: "11:00",
            titleString: "SwiftUI 레이아웃과 데이터 플로우 이해하기",
            contentString: "",
            speaker: SessionSpeakerModel(
                nameString: "허원",
                roleString: "OO회사 | 무슨 포지션",
                descriptionString: "유연한 서비스를 만드는데 관심이 많은 iOS 개발자입니다.",
                profileString: "HeoWon"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "11:10",
            endTimeString: "11:50",
            titleString: "Xcode 프로젝트와 컴파일러 인덱스로 의존성 찾기",
            contentString: "",
            speaker: SessionSpeakerModel(
                nameString: "고드름",
                roleString: "OO회사",
                descriptionString: "스위프트 뒤에서 몰래 함께한 혼열왕자 오브젝티브-C처럼 레츠스위프트 그 시작을 함께했던 교육 개발자입니다",
                profileString: "JK"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "smallRoom",
            startTimeString: "",
            endTimeString: "",
            titleString: "11:50 ~ 12:40 점심 시간",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "12:40",
            endTimeString: "13:10",
            titleString: "Metal Shader로 달라지는 UX/UI의 변화",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "안솔찬",
                roleString: "OO회사",
                descriptionString: "오래오래 일하게 해주세요",
                profileString: "AnhSolchan"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "13:20",
            endTimeString: "13:40",
            titleString: "SwiftUI border 어디까지 그려보셨나요?",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "리이오",
                roleString: "OO회사",
                descriptionString: "현업과 상관없는 개발에 관심이 많아요",
                profileString: "leeo"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "13:50",
            endTimeString: "14:30",
            titleString: "당근 iOS 프로젝트 성장기",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "당근",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "karrot",
                isTeam: true
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "14:40",
            endTimeString: "15:00",
            titleString: "Swift로 Cross Platform 하기",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "Jihoon",
                roleString: "OO회사",
                descriptionString: "다양한 방식의 접근을 좋아하는 iOS 개발자입니다",
                profileString: "AnhJihoon"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "15:00",
            endTimeString: "15:20",
            titleString: "잊지마세요 Unwind Segue - 생각보다 Segue는 \"여전히\" 유용합니다.",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "방현석",
                roleString: "OO회사",
                descriptionString: "정신 꽉 잡아!! 기획서가 또 바뀔거야!!\n서바이벌 iOS개발자 긱코드입니다.",
                profileString: "banghyunseok"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "15:30",
            endTimeString: "16:10",
            titleString: "CoreBluetooth로 BLE기기를 연동할 때 마주하는 문제들과 부딪혀보기",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "허성진",
                roleString: "OO회사",
                descriptionString: "복잡한 문제를 심플하고 유쾌하게 풀어내는 것을 좋아합니다.\n그래서 개발과 클라이밍을 좋아합니다.",
                profileString: "heoseongjin"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "16:20",
            endTimeString: "17:00",
            titleString: "iOS 애플리케이션 개발 생산성 고찰 - 빠른 퇴근을 위한 우리는 어떻게 해야할 것인가?",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "안정민",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "jung-min"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "smallRoom",
            startTimeString: "",
            endTimeString: "",
            titleString: "17:00 ~ 17:30 클로징 이벤트 및 경품 추천\n(대회의실 1)",
            contentString: "",
            speaker: nil
        ),
    ]
}
