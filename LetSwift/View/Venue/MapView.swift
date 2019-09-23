//
//  MapVieew.swift
//  LetSwift
//
//  Created by 김나용 on 23/09/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let location: CLLocationCoordinate2D
    
    init(location: CLLocationCoordinate2D) {
        self.location = location
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let span: MKCoordinateSpan = .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion.init(center: location, span: span)
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
}
