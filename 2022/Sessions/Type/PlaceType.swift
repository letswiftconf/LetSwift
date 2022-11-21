//
//  PlaceType.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

enum PlaceType {
    case bigRoom
    case smallRoom
    case Lobby
}

extension PlaceType {
    var titleString: String {
        switch self {
        case .bigRoom: return "큰큰 방바라방 여기는 큰방!"
        case .smallRoom: return "작은방방"
        case .Lobby: return "로비리비리비"
        }
    }
    
    var contentString: String {
        switch self {
        case .bigRoom:
            return """
      [큰 방]에 대한 설명을 작성해야 합니다 수정 해주세요
      안전하게 집에서 스위프트하는 방법 레츠스위프트 2020 테크토크와 함께하세요.
      매일 저녁 여러 가지 기술 주제에 대해 토론할 수 있습니다.
      """
        case .smallRoom:
            return """
      [작은 방]에 대한 설명을 작성해야 합니다 수정 해주세요
      안전하게 집에서 스위프트하는 방법 레츠스위프트 2020 테크토크와 함께하세요.
      매일 저녁 여러 가지 기술 주제에 대해 토론할 수 있습니다.
      """
        case .Lobby:
            return """
      [로비]에 대한 설명을 작성해야 합니다 수정 해주세요
      안전하게 집에서 스위프트하는 방법 레츠스위프트 2020 테크토크와 함께하세요.
      매일 저녁 여러 가지 기술 주제에 대해 토론할 수 있습니다.
      """
        }
    }
    
    private var textString: String {
        switch self {
        case .bigRoom: return "402호"
        case .smallRoom: return "401호"
        case .Lobby: return "로비"
        }
    }
}

extension PlaceType {
    func buttonView(isClicked: Bool) -> some View {
        VStack(spacing: .zero) {
            Text(self.textString)
                .font(.subheadBold)
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.bottom, isClicked ? 10 : 7)
                .frame(width: 80)
                .background(isClicked ? Color.orange : Color.clear)
                .cornerRadius(5)
            
            Rectangle()
                .fill(Color.backgroundWhite)
                .frame(width: 80, height: isClicked ? 0 : 3)
                .cornerRadius(5)
        }
    }
}

extension PlaceType: CaseIterable, Identifiable {
    var id: UUID { return UUID() }
}
