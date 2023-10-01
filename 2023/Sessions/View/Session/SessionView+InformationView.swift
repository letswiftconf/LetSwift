//
//  SessionView+InformationView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

extension SessionView {
    struct InformationView: View {
        private let informationTextString1: String =
        """
        스노클링을 해보신 경험이 있으신가요?

        바닷속에는 우리가 보지 못했던 미지의 세계가

        끝도 없이 펼쳐져 있습니다.
        """

        private let informationTextString2: String =
        """
        직접 들어가 보지 않으면 알 수 없는 세계를 탐험해 봤던 경험을
        나누는 것은 우리의 지식과 경험을 더욱 풍부하게 만들 뿐 아니라
        공유의 가치를 더해 줄 것입니다.

        이제 Deep dive 할 시간입니다!
        함께하시죠 into the unknown으로!

        조심하세요!
        너무 깊이 들어갔다간 헤어 나오지 못할지도 모릅니다!

        """

        @State
        private var isAlertOpen: Bool = false
        
        var body: some View {
            VStack(alignment: .leading, spacing: .zero) {
                // FIXME: font
                HStack(alignment: .lastTextBaseline) {
                    Text("Deep Dive")
                        .font(.head1b)

                    Spacer()

                    Text("into the unknown")
                        .font(.body1m)
                }
                .foregroundColor(.title)

                VStack(spacing: 22) {
                    Text(self.informationTextString1)
                        .font(.body1b)
                        .foregroundColor(.text)
                        .multilineTextAlignment(.center)

                    Text(self.informationTextString2)
                        .font(.body4b)
                        .foregroundColor(.subtext)
                        .multilineTextAlignment(.center)
                }
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                .padding(.top, 24)

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
                .padding(.top)
                
                RowView(
                    titleString: "일시",
                    contentString: "2023년 10월 13일  10:00 - 17:00",
                    buttons: [
                        SmallBoxButton(textString: "캘린더 추가") {
                            self.addToCalendar()
                        }
                    ]
                )
                .padding(.top, 10)
                .alert(isPresented: self.$isAlertOpen) {
                    Alert(
                        title: Text("캘린더"),
                        message: Text("캘린더에 일정이 추가되었습니다. 잊지말고 보러오세요!"),
                        dismissButton: .default(Text("확인"))
                    )
                }
                
                RowView(
                    titleString: "장소",
                    contentString: "과학기술컨벤션센터 지하1층",
                    buttons: [
                        SmallBoxButton(textString: "네이버 지도") {
                            self.urlClickAction(urlString: "https://naver.me/5SaMyyTt")
                        },
                        SmallBoxButton(textString: "카카오 지도") {
                            self.urlClickAction(urlString: "https://place.map.kakao.com/1806062978")
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
        private let buttons: [SessionView.SmallBoxButton]
        
        init(titleString: String, contentString: String, buttons: [SessionView.SmallBoxButton]) {
            self.titleString = titleString
            self.contentString = contentString
            self.buttons = buttons
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(self.titleString)
                        .font(.body1b)

                    Spacer()
                    
                    ForEach(self.buttons) { button in
                        button
                    }
                }
                
                Text(self.contentString)
                    .font(.body3r)
            }
            .foregroundColor(.text)
            .padding()
            .background(Color.primary)
            .cornerRadius(10)
            .shadow(color: .primary.opacity(0.5), radius: 2, x: 4, y: 4)
        }
    }
}

extension SessionView.InformationView {
    private func addToCalendar() {
        let manager = CalendarManager()
        switch manager.authorizationStatus {
        case .authorized:
            manager.addConference2023()
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
