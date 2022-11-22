//
//  PlaceType.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

enum PlaceType: String {
    case bigRoom
    case smallRoom
}

extension PlaceType {
    private var textString: String {
        switch self {
        case .bigRoom: return "402호"
        case .smallRoom: return "401호"
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
                .fill(Color.backgroundWhite.opacity(0.2))
                .frame(width: 80, height: isClicked ? 0 : 2)
                .cornerRadius(5)
        }
    }
}

extension PlaceType: CaseIterable, Identifiable {
    var id: UUID { return UUID() }
}
