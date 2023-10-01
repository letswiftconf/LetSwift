//
//  CardType.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/20.
//

import Foundation

struct CardType {
    
    enum CardCase: String {
        case design = "🎨미적감각왕🎨"
        case device = "🍎애플왕🍎"
        case newTech = "💻신기술왕💻"
        case conference = "🙌소통왕🙌"
        case none
        
        var color: String {
            switch self {
            case .design:
                return "cardGreen"
            case .device:
                return "cardRed"
            case .newTech:
                return "primary"
            case .conference:
                return "cardYellow"
            case .none:
                return "primary"
            }
        }
    }
    
    enum CardImageCase: String {
        case design
        case device
        case newTech
        case conference
        case none
    }
    
    enum CardSessionCase: String {
        case ai = "요즘 유행하는 AI에 진심인"
        case module = "모듈모듈 모듈화에 진심인"
        case swiftUI = "새로운 패러다임 스유에 진심인"
        case swift = "Swift 파고드는 것에 진심인"
        case productive = "공장장이 되고싶어! 생산성에 진심인"
        case macro = "매크로에 진심인"
        case bluetooth = "Bluetooth에 진심인"
        case segue = "Segue에 진심인"
        case dependancy = "의존성에 진심인"
        case metal = "Metal에 진심인"
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
    
    static func cardSession(answerId: Int) -> CardSessionCase {
        switch answerId {
        case 1: return .macro
        case 2, 3: return .productive
        case 4, 10, 11: return .swiftUI
        case 5, 13, 15: return .swift
        case 6: return .module
        case 7: return .ai
        case 8: return .segue
        case 9: return .dependancy
        case 12: return .metal
        case 14: return .bluetooth
        default: return .none
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
