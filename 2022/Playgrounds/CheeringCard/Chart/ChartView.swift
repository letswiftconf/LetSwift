//
//  ChartView.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/01.
//

import SwiftUI
import Charts

struct ChartView: View {
    @StateObject var viewModel = ChartViewModel()
    
    var body: some View {
        TabView {
            totalChart()
            individualChart()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

extension ChartView {
    @ViewBuilder
    func totalChart() -> some View {
        VStack(alignment: .leading) {
            if let chartDataList = viewModel.totalChartDataList {
                if #available(iOS 16.0, *) {
                    VStack(alignment: .leading) {
                        Text("Let’Swift 22 참여자 개발 성향")
                            .padding(.bottom, 30)
                            .font(.title)
                        Chart {
                            ForEach(chartDataList) { chartData in
                                if let question = TempChartData.questionList.first(where: { $0.surveyId == chartData.surveyId })?.question,
                                   let answer = TempChartData.getCardCase(answerId: chartData.answerId)
                                {
                                    BarMark(
                                        x: .value("Category", answer.rawValue),
                                        y: .value("Profit", chartData.count)
                                    )
                                    .foregroundStyle(by: .value("Product Category", question))
                                }
                            }
                        }
                        .frame(height: 500)
                    }
                } else {
                    Text("iOS 16.0 부터 결과를 확인할 수 있습니다 :)")
                }
            } else {
#warning("이미지 넣기")
                Text("로딩중...")
            }
            Spacer()
        }
        .padding(.top, 50)
        .padding(.horizontal, 30)
    }
    @ViewBuilder
    func individualChart() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("답변 전체 결과 보기")
                    .padding(.bottom, 30)
                    .font(.title)
                if let chartData = viewModel.chartData {
                    if #available(iOS 16.0, *) {
                        ForEach(0..<chartData.surveyList.count, id: \.self) { index in
                            Text("\(index+1). \(TempChartData.getQuestionText(surveyId: index+1))")
                                .padding(.bottom, 20)
                                .font(.title3)
                            VStack(alignment: .leading) {
                                Chart {
                                    ForEach(chartData.surveyList[index].answerList) { answer in
                                        let answerText = TempChartData.getAnswerText(surveyId: index+1, answerId: answer.answerId)
                                        if index == 0 {
                                            BarMark(
                                                x: .value("답변",answerText),
                                                y: .value("응답수", answer.count)
                                            )
                                            .foregroundStyle(by: .value("답변", answerText))
                                        } else if index == 1 {
                                            PointMark (
                                                x: .value("답변",answerText),
                                                y: .value("응답수", answer.count)
                                            )
                                            .foregroundStyle(by: .value("답변", answerText))
                                        } else if index == 2 {
                                            LineMark (
                                                x: .value("답변",answerText),
                                                y: .value("응답수", answer.count)
                                            )
                                        } else if index == 3 {
                                            RectangleMark (
                                                x: .value("답변",answerText),
                                                y: .value("응답수", answer.count)
                                            )
                                            .foregroundStyle(by: .value("답변", answerText))
                                        } else {
                                            AreaMark (
                                                x: .value("답변",answerText),
                                                y: .value("응답수", answer.count)
                                            )
                                        }
                                    }
                                }
                            }
                            .frame(height: 150)
                            .padding(.bottom, 50)
                        }
                    }
                    else {
                        Text("iOS 16.0 부터 결과를 확인할 수 있습니다 :)")
                    }
                }
                else {
#warning("이미지 넣기")
                    Text("로딩중...")
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 50)
            .padding(.bottom, 50)
        }
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
