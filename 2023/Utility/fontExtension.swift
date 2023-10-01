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


// 2023
extension Font {
    static let head1b = Font.custom("WorkSans-Bold", size: 40)
    static let head2b = Font.system(size: 30, weight: .bold)
    static let head2m = Font.system(size: 30, weight: .medium)
    static let head3b = Font.system(size: 20, weight: .bold)

    static let body1b = Font.system(size: 18, weight: .bold)
    static let body1m = Font.system(size: 18, weight: .medium)

    static let body2b = Font.system(size: 16, weight: .bold)
    static let body2m = Font.system(size: 16, weight: .medium)

    static let body3b = Font.system(size: 14, weight: .bold)
    static let body3m = Font.system(size: 14, weight: .medium)
    static let body3r = Font.system(size: 14)

    static let body4b = Font.system(size: 12, weight: .bold)
    static let body4m = Font.system(size: 12, weight: .medium)
    static let body4r = Font.system(size: 12)
}
