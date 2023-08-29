//
//  ChartViewModel.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/04.
//

import Foundation


class ChartViewModel: ObservableObject {
    @Published var chartData: ChartData? = nil {
        didSet {
            getTotalChartDataList()
        }
    }
    @Published var totalChartDataList: [TotalChartData]? = nil
    @Published var alertArror = false
    
    func getChartData() {
        APICaller.shared.getChartData ( completion: { result in
            switch result {
                case .success(let APIResponse):
                    DispatchQueue.main.async {
                        self.chartData = APIResponse
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.alertArror = true
                    }
            }
        })
    }
    
    func getTotalChartDataList() {
        var totalChartDataList: [TotalChartData] = []
        if self.chartData != nil {
            for survey in self.chartData!.surveyList {
                let surveyId = survey.surveyId
                for answer in survey.answerList {
                    let totalChartData = TotalChartData(surveyId: surveyId, answerId: answer.answerId, count: answer.count)
                    totalChartDataList.append(totalChartData)
                }
            }
            self.totalChartDataList = totalChartDataList
        }
    }
}
