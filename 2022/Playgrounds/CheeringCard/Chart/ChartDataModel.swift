//
//  ChartDataModel.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/01.
//

import SwiftUI

struct TotalChartData: Identifiable{
    let surveyId: Int
    let answerId: Int
    let count: Int
    
    var id: Int { answerId }
}

struct ChartData: Codable {
    let totalCount: Int
    let surveyList: [Survey]
}

struct Survey: Codable {
    let surveyId: Int
    let answerList: [Answer]
}

struct Answer: Codable, Identifiable {
    let answerId: Int
    let count: Int
    
    var id: Int { answerId }
}

