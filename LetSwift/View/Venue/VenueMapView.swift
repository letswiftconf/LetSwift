//
//  MapVieew.swift
//  LetSwift
//
//  Created by 김나용 on 23/09/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct VenueMapView: UIViewRepresentable {
    let location: CLLocationCoordinate2D
    
    // MARK: - Representable
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsBuildings = true
        mapView.isZoomEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = true
        mapView.isScrollEnabled = false
        let span = MKCoordinateSpan(latitudeDelta: 0.004,
                                    longitudeDelta: 0.004)
        let region = MKCoordinateRegion(center: location,
                                        span: span)
        mapView.setRegion(region, animated: false)
        
        let centerCoordinate = location
        let annotation = MKPointAnnotation()
        annotation.coordinate = centerCoordinate
        annotation.title = "양재 aT센터"
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}

// MARK: - Preview
struct VenueMapView_Previews: PreviewProvider {
    static var previews: some View {
        let layout = PreviewLayout.fixed(width: 300, height: 300)
        let location = CLLocationCoordinate2D(latitude: 37.468437,
                                              longitude: 127.039055)
        return Group {
            VenueMapView(location: location)
                .previewLayout(layout)
            VenueMapView(location: location)
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            VenueMapView(location: location)
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
