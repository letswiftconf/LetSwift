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
//                            Button(action: addToCalendar) {
//                                Text("Add to Calendar")
//                            }
//                            .font(.subheadline)
                        }
                        Divider()
                        
                        // Location
                        VStack(alignment: .leading, spacing: 6) {
                            HeadlineText("장소")
                            SubheadlineText("서울특별시 강남구 테헤란로7길 22")
//                            VStack(alignment: .leading, spacing: 16) {
//                                HStack(spacing: 16) {
//                                    Button(action: openAppleMap) {
//                                        Text("Apple Map ↗︎")
//                                    }
//                                    .font(.subheadline)
//                                    Button(action: openGoogle) {
//                                        Text("Google Maps ↗︎")
//                                    }
//                                    .font(.subheadline)
//                                }
//                                HStack(spacing: 16) {
//                                    Button(action: openNaver) {
//                                        Text("Naver Map ↗︎")
//                                    }
//                                    .font(.subheadline)
//                                    Button(action: openKakao) {
//                                        Text("Kakao Map ↗︎")
//                                    }
//                                    .font(.subheadline)
//                                }
//                            }
                        }
                        Divider()
                        
                        // Route
                        VStack(alignment: .leading, spacing: 16) {
                            HeadlineText("찾아오는 법")
                            VenueInfoCell(info: .init(title: "지하철",
                                                      body: "신분당선 '양재시민의 숲'역에서 하차 후 4번 출구"))
                            VenueInfoCell(info: .init(title: "버스",
                                                      body: "양재 aT 센터 주변 버스정류장 하차"))
//                            VStack(alignment: .leading, spacing: 16) {
//                                HStack(spacing: 16) {
//                                    Button(action: openAppleMapRoute) {
//                                        Text("Apple Map ↗︎")
//                                    }
//                                    .font(.subheadline)
//                                    Button(action: openGoogleRoute) {
//                                        Text("Google Maps ↗︎")
//                                    }
//                                    .font(.subheadline)
//                                }
//                                HStack(spacing: 16) {
//                                    Button(action: openNaverRoute) {
//                                        Text("Naver Map ↗︎")
//                                    }
//                                    .font(.subheadline)
//                                    Button(action: openKakaoRoute) {
//                                        Text("Kakao Map ↗︎")
//                                    }
//                                    .font(.subheadline)
//                                }
//                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("장소")
            .sheet(isPresented: $showEvent) {
                EventEditViewController()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
    
    private func openAppleMap() {
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02))
        let placemark = MKPlacemark(coordinate: location)
        let mapItem = MKMapItem(placemark: placemark)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        mapItem.name = "서울특별시 강남구 테헤란로7길 22"
        mapItem.openInMaps(launchOptions: options)
    }
    
    private func openAppleMapRoute() {
        let placemark = MKPlacemark(coordinate: location)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "서울특별시 강남구 테헤란로7길 22"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    private func openKakao() {
        guard let url = URL(string: "kakaomap://look?p=\(location.latitude),\(location.longitude)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func openKakaoRoute() {
        guard let url = URL(string: "kakaomap://route?ep=\(location.latitude),\(location.longitude)&by=PUBLICTRANSIT") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    private func openNaverRoute() {
        let dname = "서울특별시 강남구 테헤란로7길 22".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "nmap://route/public?dlat=\(location.latitude)&dlng=\(location.longitude)&dname=\(dname)&appname=kr.codesquad.jk.letswift") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        }
    }
    
    private func openNaver() {
        let dname = "서울특별시 강남구 테헤란로7길 22".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "nmap://place?lat=\(location.latitude)&lng=\(location.longitude)&name=\(dname)&appname=kr.codesquad.jk.letswift") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        }
    }
    
    private func openGoogle() {
        guard let url = URL(string:"comgooglemaps://?center=\(location.latitude),\(location.longitude)&zoom=14&views=traffic&q=\(location.latitude),\(location.longitude)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    private func openGoogleRoute() {
        guard let url = URL(string: "comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=transit") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
