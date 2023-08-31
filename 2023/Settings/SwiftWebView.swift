//
//  SwiftWebView.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/09.
//
import SwiftUI

struct SwiftWebView: View {
    enum letSwiftWeb: String, CaseIterable {
        case swift2022
        case swift2020
        case swift2019
        case swift2018
        case swift2017
        case swift2016
        
        var year: String {
            let startIndex = self.rawValue.index(self.rawValue.startIndex, offsetBy: 5)
            return String(self.rawValue[startIndex...])
        }
        
        var imageName: String {
            return "letSwift\(self.year)"
        }
        
        var description: String {
            switch self {
                case .swift2022:
                    return "드디어 긴 침묵 끝에, 3년 만에 2022 레츠스위프트가 오프라인으로 돌아왔습니다!"
                case .swift2020:
                    return "새로운 레츠스위프트를 만나보세요"
                case .swift2019:
                    return "스위프트 개발자에게 혹독한 변화의 계절을 함께 준비해요"
                case .swift2018:
                    return "도전하는 Swift 개발자들끼리 만나고, 배우고, 즐기는 컨퍼런스"
                case .swift2017:
                    return "더 많은 플랫폼에서 보다 다양한 활용방식을 함께 이야기해보세요."
                case .swift2016:
                    return "한국에서 열리는 Swift 컨퍼런스에서 iOS의 넥스트 스텝을 이야기해봅시다."
            }
        }
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("역대 레츠 스위프트")
                    .font(.title3Bold)
                    .padding(.top, 20)
                    .padding(.bottom, 25)
                ForEach(letSwiftWeb.allCases, id: \.self) { swiftWeb in
                    Link(destination: URL(string: "http://letswift.kr/\(swiftWeb.year)/")!) {
                        webBox(imageName: swiftWeb.imageName, year: swiftWeb.year, description: swiftWeb.description)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 200)
        }
        .foregroundColor(.white)
        .background(Color.backgroundBlack)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("", displayMode: .inline)
    }
}

extension SwiftWebView {
    @ViewBuilder func webBox(imageName: String, year: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .cornerRadius(10)
                .frame(width: 90, height: 90)
                .padding(.trailing, 19)
            VStack(alignment: .leading, spacing: 10) {
                Text(year)
                    .font(.bodyRegular)
                    .foregroundColor(.orange)
                    .padding(.top, 8)
                Text(description)
                    .multilineTextAlignment(.leading)
                    .font(.caption2Regular)
                Spacer()
            }
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.subheadRegular)
                Spacer()
            }
        }
        .padding(.bottom, 40)
    }
}

struct SwiftWebView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftWebView()
    }
}
