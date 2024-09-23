//
//  Company.swift
//  LetSwift
//
//  Created by 지준용 on 9/14/24.
//

import SwiftUI


// NFC 또는 QR 사용에 사용할 더미데이터입니다.
enum Company: String, CaseIterable {
    case company1
    case company2
    case company3
    case company4
    case company5
    case company6
    case company7
    case company8
    case company9
    case company10
    
    var payload: String {
        return self.rawValue
    }
    
    var info: CompanyInfo {
        switch self {
        case .company1:
            CompanyInfo(title: "회사1", description: "회사1에 대한 설명입니다.")
        case .company2:
            CompanyInfo(title: "회사2", description: "회사2에 대한 설명입니다.")
        case .company3:
            CompanyInfo(title: "회사3", description: "회사3에 대한 설명입니다.")
        case .company4:
            CompanyInfo(title: "회사4", description: "회사4에 대한 설명입니다.")
        case .company5:
            CompanyInfo(title: "회사5", description: "회사5에 대한 설명입니다.")
        case .company6:
            CompanyInfo(title: "회사6", description: "회사6에 대한 설명입니다.")
        case .company7:
            CompanyInfo(title: "회사7", description: "회사7에 대한 설명입니다.")
        case .company8:
            CompanyInfo(title: "회사8", description: "회사8에 대한 설명입니다.")
        case .company9:
            CompanyInfo(title: "회사9", description: "회사9에 대한 설명입니다.")
        case .company10:
            CompanyInfo(title: "회사10", description: "회사10에 대한 설명입니다.")
        }
    }
    
    struct CompanyInfo {
        let title: String
        let image: Image? = nil
        let description: String
    }
}

