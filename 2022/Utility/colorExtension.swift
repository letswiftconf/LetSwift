//
//  colorExtension.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/07.
//

import SwiftUI

///ex. Text("2022")
///.foregroundColor(.orange)

extension Color {
    static let orange = Color("orange")
    static let textGray = Color("textGray")
    // background
    static let backgroundWhite = Color("backgroundWhite")
    static let backgroundBlack = Color("backgroundBlack")
    static let backgroundCell = Color("backgroundCell")
    static let gradientStart = Color("gradientStart")
    static let gradientEnd = Color("gradientEnd")
  
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
