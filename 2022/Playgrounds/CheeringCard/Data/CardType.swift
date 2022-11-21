//
//  CardType.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/20.
//

import Foundation

struct CardType {
    
    enum CardCase: String {
        case design = "디자인에 진심인"
        case device = "애플 기기왕"
        case newTech = "신기술에 진심인"
        case conference = "소통왕"
        case none
    }
    
    enum CardImageCase: String {
        case design
        case device
        case newTech
        case conference
        case none
    }

    static func cardCase(answerId: Int) -> CardCase {
        switch answerId {
            case 1:
                return CardCase.design
            case 2:
                return CardCase.device
            case 3:
                return CardCase.newTech
            case 4:
                return CardCase.conference
            default:
                return CardCase.none
        }
    }
    
    static func cardImage(type: String) -> String {
        switch type {
        case CardCase.design.rawValue:
            return CardImageCase.design.rawValue
        case CardCase.device.rawValue:
            return CardImageCase.device.rawValue
        case CardCase.newTech.rawValue:
            return CardImageCase.newTech.rawValue
        case CardCase.conference.rawValue:
            return CardImageCase.conference.rawValue
        default:
            return CardImageCase.none.rawValue
        }
    }
    
    
}
