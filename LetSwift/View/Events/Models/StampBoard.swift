//
//  StampBoard.swift
//  LetSwift
//
//  Created by Lee Jinhee on 10/5/24.
//

import SwiftUI

struct StampBoard {
    static let boardRowCount: Int = 4
    static let screenWidth = UIScreen.main.bounds.width

    // 스탬프 판의 한 칸의 넓이 & 높이
    static let boardWidth = (screenWidth - 40) / CGFloat(StampBoard.boardRowCount)
    static let boardHeight = StampBoard.boardWidth * 10 / 7
    
    // 스탬프 이미지의 넓이 계산
    static let imageWidth = StampBoard.boardWidth * 23 / 21
}


struct StampImagePosition: Hashable {
    let x: CGFloat
    let y: CGFloat
    let imageWidth: CGFloat = StampBoard.imageWidth
    let rotation: Angle
    
    static let positions: [StampImagePosition] = [
        StampImagePosition(x: calculate(-4), y: calculate(8), rotation: .degrees(-8)),
        StampImagePosition(x: calculate(5), y: calculate(8), rotation: .degrees(15)),
        StampImagePosition(x: calculate(14), y: calculate(0), rotation: .degrees(-20)),
        StampImagePosition(x: calculate(8), y: calculate(8), rotation: .degrees(9)),
        StampImagePosition(x: calculate(-4), y: calculate(4), rotation: .degrees(20)),
        StampImagePosition(x: calculate(-2.5), y: calculate(-5), rotation: .degrees(-13)),
        StampImagePosition(x: calculate(3), y: calculate(8), rotation: .degrees(0)),
        StampImagePosition(x: calculate(8), y: calculate(-4), rotation: .degrees(-20))
    ]

    // 스탬프 좌표 계산 함수
    static func calculate(_ value: CGFloat) -> CGFloat {
        value * StampBoard.imageWidth / 92
    }
}
