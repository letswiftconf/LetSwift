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
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let span: MKCoordinateSpan = .init(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let region: MKCoordinateRegion = .init(center: location, span: span)
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
}
