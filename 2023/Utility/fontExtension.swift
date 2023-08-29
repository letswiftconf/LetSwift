//
//  fontExtension.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/07.
//
import SwiftUI

///ex. Text("2022")
///.font(.bodyRegular)
extension Font {
    static let bodyRegular = Font.body.weight(.regular)
    static let bodyBold = Font.body.weight(.bold)
    
    static let subheadRegular = Font.subheadline.weight(.regular)
    static let subheadBold = Font.subheadline.weight(.bold)
    
    static let title = Font.title.weight(.regular)
    static let title3Reqular = Font.title3.weight(.regular)
    static let title3Bold = Font.title3.weight(.bold)
    
    static let caption2Regular = Font.caption2.weight(.regular)
    static let footnote = Font.footnote.weight(.regular)
  
    // TODO: add `Inter`
}
