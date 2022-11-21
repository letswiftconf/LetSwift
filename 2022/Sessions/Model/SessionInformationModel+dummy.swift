//
//  SessionInformationModel+dummy.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/21.
//

import SwiftUI

extension SessionInformationModel {
    /// dummy for test
    static let dummys: [SessionInformationModel] = [
        SessionInformationModel(
            rowType: .hasDetailView,
            placeType: .bigRoom,
            time: Time(startString: "10:00", endString: "11:00"),
            titleString: "큰방에서 살아남기1",
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
            rowType: .normal,
            placeType: .bigRoom,
            time: Time(startString: "10:30", endString: "10:50"),
            titleString: "오프닝"
        ),
        SessionInformationModel(
            rowType: .otherTimes,
            placeType: .bigRoom,
            time: Time(startString: "11:50", endString: "12:30"),
            titleString: "점심 시간"
        ),
        SessionInformationModel(
            rowType: .hasDetailView,
            placeType: .bigRoom,
            time: Time(startString: "10:00", endString: "11:00"),
            titleString: "큰방에서 살아남기2",
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
            rowType: .hasDetailView,
            placeType: .bigRoom,
            time: Time(startString: "10:00", endString: "11:00"),
            titleString: "큰방에서 살아남기3",
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
            rowType: .hasDetailView,
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
            rowType: .hasDetailView,
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
            rowType: .hasDetailView,
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
            rowType: .hasDetailView,
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
            rowType: .hasDetailView,
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
            rowType: .hasDetailView,
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
