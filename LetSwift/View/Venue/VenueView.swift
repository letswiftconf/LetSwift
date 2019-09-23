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

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    MapView(location: location)
                        .frame(height: 300)
                    VStack(alignment: .leading) {
                        Text("양재 aT 센터")
                            .font(.headline)
                        Text("일시")
                            .font(.headline)
                        Text("11월 12일 (화) 오전 9시부터 오후 6시까지")
                        Text("주소")
                            .font(.headline)
                        Text("서울특별시 강남구 테헤란로7길 22")
                        Text("지하철")
                            .font(.headline)
                        Text("신분당선 “양재시민의 숲”역에서 하차 후 4번 출구")
                        Text("버스")
                            .font(.headline)
                        Text("at 센터 주변 버스정류장 하차")
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Venue")
        }
    }
}

#if DEBUG
struct VenueView_Previews: PreviewProvider {
    static var previews: some View {
        VenueView()
    }
}
#endif
