//
//  VenueView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI
import MapKit

struct VenueView: View {
    let location: CLLocationCoordinate2D = .init(latitude: 37.468437, longitude: 127.039055)
    
    @State private var showEvent = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    MapView(location: location)
                        .modifier(RoundedMask())
                        .frame(height: 300)
                        .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 24) {
                        // Time
                        VStack(alignment: .leading, spacing: 6) {
                            HeadlineText("일시")
                            VenueInfoCell(info: .init(title: "11월 12일 화요일",
                                                      body: "오전 9시부터 오후 6시까지"))
                            Button(action: addToCalendar) {
                                Text("Add to Calendar")
                            }
                            .font(.subheadline)
                        }
                        Divider()
                        
                        // Location
                        VStack(alignment: .leading, spacing: 6) {
                            HeadlineText("일시")
                            SubheadlineText("서울특별시 강남구 테헤란로7길 22")
                            Button(action: addToCalendar) {
                                Text("Show in...")
                            }
                            .font(.subheadline)
                        }
                        Divider()
                        
                        // Route
                        VStack(alignment: .leading, spacing: 16) {
                            HeadlineText("찾아오는 법")
                            VenueInfoCell(info: .init(title: "지하철",
                                                      body: "신분당선 '양재시민의 숲'역에서 하차 후 4번 출구"))
                            VenueInfoCell(info: .init(title: "버스",
                                                      body: "양재 aT 센터 주변 버스정류장 하차"))
                            Button(action: addToCalendar) {
                                Text("Find Route on Apple Map")
                            }
                            .font(.subheadline)
                            Button(action: addToCalendar) {
                                Text("Find Route on Google Maps")
                            }
                            .font(.subheadline)
                            Button(action: addToCalendar) {
                                Text("Find Route on Naver Map")
                            }
                            .font(.subheadline)
                            Button(action: addToCalendar) {
                                Text("Find Route on Kakao Map")
                            }
                            .font(.subheadline)
                        }
                    }
                    .padding()
                }
//                .padding(.horizontal)
            }
            .navigationBarTitle("Venue")
            .sheet(isPresented: $showEvent) {
                EventEditViewController()
            }
        }
    }
    
    // MARK: - Action
    private func addToCalendar() {
        showEvent.toggle()
//        let manager = CalendarManager()
//        switch manager.authorizationStatus {
//        case .authorized:
//            manager.addConference2019()
//        case .denied, .restricted:
//            // TODO: Show error
//            break
//        case .notDetermined:
//            manager.requestAccess { (granted, error) in
//                self.addToCalendar()
//            }
//        @unknown default:
//            #if DEBUG
//            fatalError()
//            #endif
//        }
    }
}

struct VenueInfoCell: View {
    let info: VenueInfo
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            SubheadlineText(info.title)
            SubheadlineText(info.body)
        }
    }
}

struct VenueInfo {
    let title: String
    let body: String
}

// MARK: - Preview
struct VenueView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VenueView()
            VenueView()
                .environment(\.colorScheme, .dark)
            VenueView()
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
