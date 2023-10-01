//
//  SelfieFrame.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/24.
//

import Foundation

enum SelfieFrameType: Int, CaseIterable {
    case typeA = 1
    case typeB = 2
    case typeC = 3
}

struct SelfieEntity: CaseIterable, Identifiable {
    
    static var allCases: [SelfieEntity] = SelfieFrameType.allCases.map { type -> SelfieEntity in
        return SelfieEntity(type: type)
    }

    let type: SelfieFrameType
    
    var id: Int {
        get {
            return type.rawValue
        }
    }
    
    var frameImage: String {
        get {
            return "selfie_layout_\(type.rawValue)"
        }
    }
    
    var thumbImage: String {
        get {
            return "selfie_thumb_\(type.rawValue)"
        }
    }
    
    var maskingImage: String {
        get {
            switch type {
            case .typeC:
                return "selfie_masking_2"
            default:
                return "selfie_masking_1"
            }
        }
        
        set {
            
        }
    }
}
