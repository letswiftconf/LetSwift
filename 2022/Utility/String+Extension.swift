//
//  String+Extension.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/11.
//

import UIKit

extension String {
    func convertString(text: String , highlightColor: UIColor = .systemOrange, font: UIFont = .systemFont(ofSize:16) ,alignment:  NSTextAlignment = .natural) -> NSMutableAttributedString {
        
        let attributedStr = NSMutableAttributedString(string: self)
        attributedStr.addAttribute(.font, value: font, range: (self as NSString).range(of: text))
        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightColor, range: (self as NSString).range(of: text))
        
        let myParagraphStyle = NSMutableParagraphStyle()
        myParagraphStyle.alignment = alignment
        attributedStr.addAttributes([.paragraphStyle: myParagraphStyle], range: (self as NSString).range(of: self))
        
        return attributedStr
        
    }
    
    func utf8EncodedString() -> String {
        guard let messageData = self.data(using: .nonLossyASCII),
              let text = String(data: messageData, encoding: .utf8)
        else { return "" }
        
        return text
    }
}
