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
        .task {
            viewModel.getChartData()
        }
        .foregroundColor(.white)
        .background(Color.backgroundBlack)
        .edgesIgnoringSafeArea(.bottom)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

extension ChartView {
    @ViewBuilder
    func totalChart() -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Let’Swift 22 개발자 성향")
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title3Bold)
                if let chartDataList = viewModel.totalChartDataList {
                    if #available(iOS 16.0, *) {
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
                    } else {
                        iOS16View()
                    }
                    Spacer()
                } else if viewModel.alertArror == true {
                    alertErrorView()
                } else {
                    loadingView()
                }
            }
        }
        .padding(.top, 50)
        .padding(.horizontal, 30)
    }
    @ViewBuilder
    func individualChart() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Let’Swift 22 답변 결과")
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title3Bold)
                if let chartData = viewModel.chartData {
                    if #available(iOS 16.0, *) {
                        ForEach(0..<chartData.surveyList.count, id: \.self) { index in
                            Text("\(index+1). \(TempChartData.getQuestionText(surveyId: index+1))")
                                .padding(.bottom, 20)
                                .font(.title3Reqular)
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
                        iOS16View()
                    }
                } else if viewModel.alertArror == true {
                    alertErrorView()
                } else {
                    loadingView()
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 30)
            .padding(.bottom, 50)
        }
    }
    @ViewBuilder
    func loadingView() -> some View {
        VStack(alignment: .center) {
            Image("loading")
                .resizable()
                .scaledToFit()
                .frame(width: 66, height: 66)
                .padding(.bottom, 26)
                .padding(.top, 40)
            Text("LOADING")
                .font(.title3Bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 14)
            Text("잠시만 기다려주시기 바랍니다.")
                .font(.footnote)
            Spacer()
        }
        .padding(.top, 100)
    }
    @ViewBuilder
    func iOS16View() -> some View {
        VStack(alignment: .center) {
            Image("iOS16")
                .resizable()
                .scaledToFit()
                .frame(width: 66, height: 66)
                .padding(.bottom, 26)
                .padding(.top, 40)
            Text("해당 화면은 \niOS 16부터 지원합니다.")
                .font(.title3Bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 14)
            Text("업데이트 후 다시 이용해주시기 바랍니다.")
                .font(.footnote)
            Spacer()
        }
        .padding(.top, 100)
    }
    @ViewBuilder
    func alertErrorView() -> some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Image("loading")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 66, height: 66)
                    .padding(.bottom, 26)
                    .padding(.top, 40)
                Text("네트워크 연결 없음")
                    .font(.title3Bold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 14)
                Button {
                    Task {
                        viewModel.getChartData()
                    }
                } label: {
                    Text("재시도 하기")
                        .font(.subheadRegular)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(gradationBox())
                }
                Spacer()
            }
            .padding(.top, 100)
        }
    }
    @ViewBuilder func gradationBox() -> some View {
        Rectangle()
            .fill(LinearGradient.gradientOrange.opacity(0.45))
            .cornerRadius(10)
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
