//
//  ChartViewModel.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/04.
//

import Foundation


class ChartViewModel: ObservableObject {
    @Published var chartData: ChartData?
    @Published var totalChartDataList: [TotalChartData]?
    
    init() {
        self.chartData = getChartMockData()
        self.totalChartDataList = getTotalChartDataList()
    }
    
    private func getChartMockData() -> ChartData? {
        guard let path = Bundle.main.path(forResource: "ChartMockData", ofType: "json") else {
            return nil
        }
        guard let jsonString = try? String(contentsOfFile: path) else {
            return nil
        }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        guard let jsonData = data,
              let chartData = try? decoder.decode(ChartData.self, from: jsonData) else {
            return nil
        }
        return chartData
    }
    
    private func getTotalChartDataList() -> [TotalChartData]? {
        var totalChartDataList: [TotalChartData] = []
        if chartData != nil {
            for survey in self.chartData!.surveyList {
                let surveyId = survey.surveyId
                for answer in survey.answerList {
                    let totalChartData = TotalChartData(surveyId: surveyId, answerId: answer.answerId, count: answer.count)
                    totalChartDataList.append(totalChartData)
                }
            }
            return totalChartDataList
        } else {
            return nil
        }
    }
}
