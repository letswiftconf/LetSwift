//
//  SessionView+InformationView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

private typealias GradientButton = SessionView.OrangeButton

extension SessionView {
    struct InformationView: View {
        private let informationTextString: String = """
    지난 3년 간 다채로운 행사와 다양한 만남에 목말라 있었나요?\n
    드디어 긴 침묵 끝에, 3년 만에 2022 레츠스위프트가 오프라인으로 돌아왔습니다!\n
    함께 Swift Playground에서 만나고, 배우고, 즐겨요!
    """
        
        @State
        private var isAlertOpen: Bool = false
        
        var body: some View {
            VStack(alignment: .leading, spacing: .zero) {
                // FIXME: font
                Text("Let’Swift 2022")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text(self.informationTextString)
                    .foregroundColor(.white)
                    .font(.bodyRegular)
                    .padding(.top, 22)
                
                HStack(spacing: 15) {
                    Button(
                        action: { self.urlClickAction(urlString: "https://twitter.com/letswiftkr") },
                        label: { Image.Logo.twitter }
                    )
                    
                    Button(
                        action: { self.urlClickAction(urlString: "https://www.instagram.com/letswiftkr") },
                        label: { Image.Logo.instagram }
                    )
                    
                    Spacer()
                }
                .padding(.top, 28)
                
                RowView(
                    titleString: "일시",
                    contentString: "2022년 11월30일  10:00 - 17:00",
                    buttons: [
                        OrangeButton(textString: "캘린더 추가") {
                            self.addToCalendar()
                        }
                    ]
                )
                .padding(.top, 46)
                .alert(isPresented: self.$isAlertOpen) {
                    Alert(
                        title: Text("캘린더"),
                        message: Text("캘린더에 일정이 추가되었습니다. 잊지말고 보러오세요!"),
                        dismissButton: .default(Text("확인"))
                    )
                }
                
                RowView(
                    titleString: "장소",
                    contentString: "서울 서초구 aT센터 (창조룸 I,II)",
                    buttons: [
                        OrangeButton(textString: "네이버 지도") {
                            self.urlClickAction(urlString: "https://naver.me/GY2c6JbS")
                        },
                        OrangeButton(textString: "카카오 지도") {
                            self.urlClickAction(urlString: "https://place.map.kakao.com/17023403")
                        }
                    ]
                )
                .padding(.top, 20)
            }
        }
    }
}

extension SessionView.InformationView {
    struct RowView: View {
        private let titleString: String
        private let contentString: String
        private let buttons: [GradientButton]
        
        init(titleString: String, contentString: String, buttons: [SessionView.OrangeButton]) {
            self.titleString = titleString
            self.contentString = contentString
            self.buttons = buttons
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                HStack(spacing: 9) {
                    Text(self.titleString)
                        .font(.bodyBold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    ForEach(self.buttons) { button in
                        button
                    }
                }
                
                Text(self.contentString)
                    .font(.subheadRegular)
                    .foregroundColor(.white)
            }
            .padding(20)
            .background(Color.backgroundCell)
            .cornerRadius(10)
        }
    }
}

extension SessionView.InformationView {
    private func addToCalendar() {
        let manager = CalendarManager()
        switch manager.authorizationStatus {
        case .authorized:
            manager.addConference2022()
            self.isAlertOpen = true
        case .denied, .restricted:
            // TODO: Show error
            break
        case .notDetermined:
            manager.requestAccess { (granted, error) in
                addToCalendar()
            }
        @unknown default:
            print("unknown error..")
            break
        }
    }
    
    private func urlClickAction(urlString: String) {
        guard let url: URL = URL(string: urlString),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
