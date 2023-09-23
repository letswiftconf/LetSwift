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
      
      enum CodingKeys: String, CodingKey {
        case nameString = "name"
        case roleString = "role"
        case descriptionString = "description"
        case profileString = "profile"
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
                descriptionString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "bigRoom",
            startTimeString: "11:00",
            endTimeString: "11:10",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
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
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "bigRoom",
            startTimeString: "",
            endTimeString: "",
            titleString: "점심 시간\n11:50 ~ 12:40 ",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "12:40",
            endTimeString: "13:40",
            titleString: "객체가 함수를 만났을 때",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "권문범",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "bigRoom",
            startTimeString: "13:40",
            endTimeString: "13:50",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "13:50",
            endTimeString: "14:30",
            titleString: "스위프트 매크로, 어디다 쓰죠?",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "노경섭",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "bigRoom",
            startTimeString: "14:30",
            endTimeString: "14:40",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "14:40",
            endTimeString: "15:10",
            titleString: "잊지마세요 Unwind Segue - 생각보다 Segue는 \"여전히\" 유용합니다.",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "김성종",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "15:10",
            endTimeString: "15:30",
            titleString: "잊지마세요 Unwind Segue - 생각보다 Segue는 \"여전히\" 유용합니다.",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "방현석",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "bigRoom",
            startTimeString: "15:30",
            endTimeString: "15:40",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "15:40",
            endTimeString: "16:10",
            titleString: "Tuist, 도입은 했는데 그래서 Modular Architecture 은 어떻게 만들어가면 되나요?",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "김우성",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "bigRoom",
            startTimeString: "16:10",
            endTimeString: "16:20",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "16:20",
            endTimeString: "16:50",
            titleString: "요즘유행하는 AI 나도 해보자 (feat. CoreML)",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "곰튀김",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "이미지url"
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
                descriptionString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "smallRoom",
            startTimeString: "11:00",
            endTimeString: "11:10",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
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
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "smallRoom",
            startTimeString: "",
            endTimeString: "",
            titleString: "점심 시간\n11:50 ~ 12:40 ",
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
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "smallRoom",
            startTimeString: "13:10",
            endTimeString: "13:20",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
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
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "smallRoom",
            startTimeString: "13:40",
            endTimeString: "13:50",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
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
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "smallRoom",
            startTimeString: "14:30",
            endTimeString: "14:40",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "14:40",
            endTimeString: "15:20",
            titleString: "Swift로 Cross Platform 하기",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "Jihoon",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "smallRoom",
            startTimeString: "15:20",
            endTimeString: "15:30",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
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
                descriptionString: "무슨포지션",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "normal",
            placeTypeString: "smallRoom",
            startTimeString: "16:10",
            endTimeString: "16:20",
            titleString: "쉬는시간",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "smallRoom",
            startTimeString: "16:20",
            endTimeString: "16:50",
            titleString: "iOS 애플리케이션 개발 생산성 고찰 - 빠른 퇴근을 위한 우리는 어떻게 해야할 것인가?",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "안정민",
                roleString: "OO회사",
                descriptionString: "무슨포지션",
                profileString: "이미지url"
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
