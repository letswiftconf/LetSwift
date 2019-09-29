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
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    MapView(location: location)
                        .mask(
                            RoundedRectangle(cornerRadius: 9, style: .continuous)
                                .frame(height: 300)
                    )
                        .frame(height: 300)
                        .padding(.horizontal)
                    
                    
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("양재 aT 센터")
                                .font(.headline)
                            Text("서울특별시 강남구 테헤란로7길 22")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 6) {
                            Text("일시")
                                .font(.headline)
                            VenueInfoCell(info: .init(title: "11월 12일 화요일",
                                                      body: "오전 9시부터 오후 6시까지"))
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 16) {
                            Text("찾아오는 법")
                                .font(.headline)
                            VenueInfoCell(info: .init(title: "지하철",
                                                      body: "신분당선 '양재시민의 숲'역에서 하차 후 4번 출구"))
                            VenueInfoCell(info: .init(title: "버스",
                                                      body: "양재 aT 센터 주변 버스정류장 하차"))
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Venue")
        }
    }
}

struct VenueInfoCell: View {
    let info: VenueInfo
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(info.title)
            Text(info.body)
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
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
