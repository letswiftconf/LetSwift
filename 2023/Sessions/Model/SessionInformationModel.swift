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
            startTimeString: "10:30",
            endTimeString: "10:50",
            titleString: "오프닝",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "12:00",
            endTimeString: "12:20",
            titleString: "스위프트 매크로, 어디다 쓰죠?",
            contentString: "",
            speaker: SessionSpeakerModel(
                nameString: "김성종",
                roleString: "OO회사 | 무슨 포지션",
                descriptionString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
                profileString: "이미지url"
            )
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "13:00",
            endTimeString: "13:20",
            titleString: "스위프트 매크로, 어디다 쓰죠?",
            contentString: "",
            speaker: SessionSpeakerModel(
                nameString: "김성종",
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
            titleString: "11:50 ~ 12:30 점심 시간",
            contentString: "",
            speaker: nil
        ),
        SessionInformationModel(
            rowTypeString: "hasDetailView",
            placeTypeString: "bigRoom",
            startTimeString: "13:00",
            endTimeString: "13:20",
            titleString: "스위프트 매크로, 어디다 쓰죠?",
            contentString: "연사자의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나",
            speaker: SessionSpeakerModel(
                nameString: "김성종",
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
    ]
}
