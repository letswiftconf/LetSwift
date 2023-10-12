//
//  Sesseion+Map.swift
//  LetSwift
//
//  Created by Dongju on 10/8/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5007029, longitude: 127.0307453),
        span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.003)
    )
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [AnnotationItem.example]){ item in
            MapAnnotation(coordinate: item.coordinate, anchorPoint: CGPoint(x: 0.89, y: 0.89)) {
                Image("marker")
                    .padding()
                Text("행사장")
                    .font(.caption)
            }
        }
    }
}


struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

extension AnnotationItem {
    static var example = AnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 37.5007029, longitude: 127.0307453))
}
