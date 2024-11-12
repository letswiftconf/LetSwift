//
//  Font+Extensions.swift
//  LetSwift
//
//  Created by duri on 8/20/24.
//

import SwiftUI

extension Font {
    public static func bold(size: CGFloat) -> Font {
        return .custom("Pretendard-Bold", size: size)
    }
    
    public static func semiBold(size: CGFloat) -> Font {
        return .custom("Pretendard-SemiBold", size: size)
    }
    
    public static func medium(size: CGFloat) -> Font {
        return .custom("Pretendard-Medium", size: size)
    }
    
    public static func regular(size: CGFloat) -> Font {
        return .custom("Pretendard-regular", size: size)
    }
}
