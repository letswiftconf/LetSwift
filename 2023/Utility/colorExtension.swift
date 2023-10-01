//
//  colorExtension.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/07.
//

import SwiftUI

///ex. Text("2022")
///.foregroundColor(.orange)
/////////

// 2023
extension Color {
    static let bg = Color("bg")
    static let primary = Color("primary")
    static let title = Color("title")
    static let subtitle = Color("subtitle")
    static let text = Color("text")
    static let subtext = Color("subtext")
    static let line = Color("line")
    // cardColor
    static let cardRed = Color("cardRed")
    static let cardYellow = Color("cardYellow")
    static let cardGreen = Color("cardGreen")
}

extension Color {
    static let orange = Color("orange")
    static let textGray = Color("textGray")
    static let cardTextGray = Color("cardTextGray")
    // background
    static let backgroundWhite = Color("backgroundWhite")
    static let backgroundBlack = Color(hex: 0x071420, alpha: 1)
    static let backgroundCell = Color("backgroundCell")
    static let gradientStart = Color("gradientStart")
    static let gradientEnd = Color("gradientEnd")
    
    static let primary_2023 = Color(hex: 0x0047FF, alpha: 1)
  
  enum Gradient {
    static let orange: LinearGradient = LinearGradient(
      gradient: .init(colors: [.gradientStart.opacity(0.45), gradientEnd.opacity(0.45)]),
      startPoint: .leading,
      endPoint: .trailing
    )
    
    public static func single(color: Color) -> LinearGradient {
      return LinearGradient(
        gradient: .init(colors: [color]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
    }
  }
    
    // border
    static let borderGray = Color("borderGray")
}
