//
//  SessionInformationModel.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

struct SessionInformationModel {
  let placeType: PlaceType
  let time: SessionInformationModel.Time
  let titleString: String
  let contentString: String
  let speaker: SessionInformationModel.Speaker
}

extension SessionInformationModel {
  struct Time {
    let startString: String
    let endString: String
  }
  
  struct Speaker {
    let nameString: String
    let companyString: String
    let introductionString: String
    let profileImage: Image
  }
}

extension SessionInformationModel: Identifiable {
  var id: UUID { return UUID() }
}

// MARK: - dummy for test

extension SessionInformationModel {
  static let dummys: [SessionInformationModel] = [
    SessionInformationModel(
      placeType: .bigRoom,
      time: Time(startString: "10:00", endString: "11:00"),
      titleString: "큰방에서 살아남기",
      contentString: """
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      """,
      speaker: Speaker(
        nameString: "강경",
        companyString: "KangKyung | CEO",
        introductionString: """
        개발자님의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나서, 나와 다른 사람들의 사고를 이해하고 목표를 존중하고 그들이 지나간 발자취들을 살펴보는 일은 너무나도 값진 경험들이었습니다. 이러한 경험들을 계속 하다보니 나도 나만의 것들을 다른 사람에게 공유하고 싶어졌습니다. 레츠스위프트 컨퍼런스에 참여할 수 있어서 영광입니다 :)
        """,
        profileImage: Image.Dummy.profile
      )
    ),
    SessionInformationModel(
      placeType: .bigRoom,
      time: Time(startString: "10:00", endString: "11:00"),
      titleString: "큰방에서 살아남기",
      contentString: """
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      """,
      speaker: Speaker(
        nameString: "강경",
        companyString: "KangKyung | CEO",
        introductionString: """
        개발자님의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나서, 나와 다른 사람들의 사고를 이해하고 목표를 존중하고 그들이 지나간 발자취들을 살펴보는 일은 너무나도 값진 경험들이었습니다. 이러한 경험들을 계속 하다보니 나도 나만의 것들을 다른 사람에게 공유하고 싶어졌습니다. 레츠스위프트 컨퍼런스에 참여할 수 있어서 영광입니다 :)
        """,
        profileImage: Image.Dummy.profile
      )
    ),
    SessionInformationModel(
      placeType: .bigRoom,
      time: Time(startString: "10:00", endString: "11:00"),
      titleString: "큰방에서 살아남기",
      contentString: """
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      큰방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      """,
      speaker: Speaker(
        nameString: "강경",
        companyString: "KangKyung | CEO",
        introductionString: """
        개발자님의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나서, 나와 다른 사람들의 사고를 이해하고 목표를 존중하고 그들이 지나간 발자취들을 살펴보는 일은 너무나도 값진 경험들이었습니다. 이러한 경험들을 계속 하다보니 나도 나만의 것들을 다른 사람에게 공유하고 싶어졌습니다. 레츠스위프트 컨퍼런스에 참여할 수 있어서 영광입니다 :)
        """,
        profileImage: Image.Dummy.profile
      )
    ),
    SessionInformationModel(
      placeType: .smallRoom,
      time: Time(startString: "10:00", endString: "11:00"),
      titleString: "작은방 이야기",
      contentString: """
      방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
      """,
      speaker: Speaker(
        nameString: "강경",
        companyString: "KangKyung | CEO",
        introductionString: """
        개발자님의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나서, 나와 다른 사람들의 사고를 이해하고 목표를 존중하고 그들이 지나간 발자취들을 살펴보는 일은 너무나도 값진 경험들이었습니다. 이러한 경험들을 계속 하다보니 나도 나만의 것들을 다른 사람에게 공유하고 싶어졌습니다. 레츠스위프트 컨퍼런스에 참여할 수 있어서 영광입니다 :)
        """,
        profileImage: Image.Dummy.profile
      )
    ),
    SessionInformationModel(
      placeType: .Lobby,
      time: Time(startString: "10:00", endString: "11:00"),
      titleString: "더미더미더미 오오오오",
      contentString: """
      더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오
      """,
      speaker: Speaker(
        nameString: "강경",
        companyString: "KangKyung | CEO",
        introductionString: """
        개발자님의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나서, 나와 다른 사람들의 사고를 이해하고 목표를 존중하고 그들이 지나간 발자취들을 살펴보는 일은 너무나도 값진 경험들이었습니다. 이러한 경험들을 계속 하다보니 나도 나만의 것들을 다른 사람에게 공유하고 싶어졌습니다. 레츠스위프트 컨퍼런스에 참여할 수 있어서 영광입니다 :)
        """,
        profileImage: Image.Dummy.profile
      )
    ),
    SessionInformationModel(
      placeType: .smallRoom,
      time: Time(startString: "10:00", endString: "11:00"),
      titleString: "작은방 이야기",
      contentString: """
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        """,
      speaker: Speaker(
        nameString: "강경",
        companyString: "KangKyung | CEO",
        introductionString: """
          개발자님의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나서, 나와 다른 사람들의 사고를 이해하고 목표를 존중하고 그들이 지나간 발자취들을 살펴보는 일은 너무나도 값진 경험들이었습니다. 이러한 경험들을 계속 하다보니 나도 나만의 것들을 다른 사람에게 공유하고 싶어졌습니다. 레츠스위프트 컨퍼런스에 참여할 수 있어서 영광입니다 :)
          """,
        profileImage: Image.Dummy.profile
      )
    ),
    SessionInformationModel(
      placeType: .Lobby,
      time: Time(startString: "10:00", endString: "11:00"),
      titleString: "더미더미더미 오오오오",
      contentString: """
        더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오
        """,
      speaker: Speaker(
        nameString: "강경",
        companyString: "KangKyung | CEO",
        introductionString: """
          개발자님의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나서, 나와 다른 사람들의 사고를 이해하고 목표를 존중하고 그들이 지나간 발자취들을 살펴보는 일은 너무나도 값진 경험들이었습니다. 이러한 경험들을 계속 하다보니 나도 나만의 것들을 다른 사람에게 공유하고 싶어졌습니다. 레츠스위프트 컨퍼런스에 참여할 수 있어서 영광입니다 :)
          """,
        profileImage: Image.Dummy.profile
      )
    ),
    SessionInformationModel(
      placeType: .smallRoom,
      time: Time(startString: "10:00", endString: "11:00"),
      titleString: "작은방 이야기",
      contentString: """
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        방에서 살아남기 위해서는 큰 마음을 가져야 합니다.
        """,
      speaker: Speaker(
        nameString: "강경",
        companyString: "KangKyung | CEO",
        introductionString: """
          개발자님의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나서, 나와 다른 사람들의 사고를 이해하고 목표를 존중하고 그들이 지나간 발자취들을 살펴보는 일은 너무나도 값진 경험들이었습니다. 이러한 경험들을 계속 하다보니 나도 나만의 것들을 다른 사람에게 공유하고 싶어졌습니다. 레츠스위프트 컨퍼런스에 참여할 수 있어서 영광입니다 :)
          """,
        profileImage: Image.Dummy.profile
      )
    ),
    SessionInformationModel(
      placeType: .Lobby,
      time: Time(startString: "10:00", endString: "11:00"),
      titleString: "더미더미더미 오오오오",
      contentString: """
        더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오 더미더미더미 오오오오
        """,
      speaker: Speaker(
        nameString: "강경",
        companyString: "KangKyung | CEO",
        introductionString: """
          개발자님의 본인 소개가 들어가는 부분입니다. 예시입니다. ios 생태계에서 공부를 하며 많은 사고들이 바뀌었지만, 가장 중요하면서 컸던 사고의 변화는 “다양성”의 중요성에 대한 이해였습니다. 다름을 다양성으로 받아들이고 나서, 나와 다른 사람들의 사고를 이해하고 목표를 존중하고 그들이 지나간 발자취들을 살펴보는 일은 너무나도 값진 경험들이었습니다. 이러한 경험들을 계속 하다보니 나도 나만의 것들을 다른 사람에게 공유하고 싶어졌습니다. 레츠스위프트 컨퍼런스에 참여할 수 있어서 영광입니다 :)
          """,
        profileImage: Image.Dummy.profile
      )
    )
  ]
}
