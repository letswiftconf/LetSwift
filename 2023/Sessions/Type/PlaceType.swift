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
    var textString: String {
        switch self {
        case .bigRoom: return "대회의실 1"
        case .smallRoom: return "대회의실 2"
        }
    }
}

extension PlaceType {
    func buttonView(isClicked: Bool) -> some View {
        VStack(alignment: .center, spacing: .zero) {
            Text(self.textString)
                .font(.body3b)
                .foregroundColor(.white)
                .frame(width: (UIScreen.main.bounds.width - 40) / 2)
                .padding(.top, 10)
                .padding(.bottom, isClicked ? 10 : 7)
                .background(isClicked ? Color.primary : Color.clear)
                .cornerRadius(5)
            
            Rectangle()
                .fill(Color.primary.opacity(0.2))
                .frame(height: isClicked ? 0 : 2)
                .cornerRadius(5)
        }
        .shadow(color: .primary.opacity(0.5), radius: 2, x: 4, y: 4)
    }
}

extension PlaceType: CaseIterable, Identifiable {
    var id: UUID { return UUID() }
}
