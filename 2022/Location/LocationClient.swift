import CoreLocation
import Foundation
import MapKit

struct LocationClient {
    let distanceStream: (_ venue: ConferenceVenue) -> AsyncThrowingStream<Double, Error>
}

extension LocationClient {
    enum InternalError: Error {
        case denied
        case unexpected
    }
    
    @available(iOS 16.1, *)
    static let live: LocationClient = {
        let manager = Manager()
        
        return LocationClient { venue in
            return .init { continuation in
                Task {
                    do {
                        if manager.isAuthorized {
                            manager.startUpdatingLocation()
                        }
                        for try await location in try manager.locationStream() {
                            let distance = try await buildCLLocationDistance(
                                location: location,
                                destination: venue.mapItem
                            )
                            if distance > 1000 {
                                continuation.yield(with: .success(distance))
                            } else {
                                continuation.finish()
                                manager.stopUpdatingLocation()
                            }
                            try await Task.sleep(for: .seconds(5))
                        }
                    } catch {
                        manager.stopUpdatingLocation()
                        continuation.yield(with: .failure(error))
                    }
                }
            }
        }
    }()
}

extension LocationClient {
    final class Manager: NSObject, CLLocationManagerDelegate {
        private lazy var manager: CLLocationManager = {
            let manager = CLLocationManager()
            manager.delegate = self
            manager.allowsBackgroundLocationUpdates = true
            manager.showsBackgroundLocationIndicator = true
            
            return manager
        }()
        var isAuthorized: Bool {
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                return true
                
            default:
                return false
            }
        }
        private var locationContinuation: AsyncThrowingStream<CLLocation, Error>.Continuation?
        
        override init() {
            super.init()
            config()
        }
        
        func locationStream() throws -> AsyncThrowingStream<CLLocation, Error> {
            let flag = manager.authorizationStatus != .restricted &&
            manager.authorizationStatus != .denied
            guard flag else { throw InternalError.denied }
            return AsyncThrowingStream { continuation in
                self.locationContinuation = continuation
            }
        }
        
        private func config() {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
                
            case .notDetermined:
                manager.requestAlwaysAuthorization()
                
            default:
                break
            }
        }
        
        func startUpdatingLocation() {
            manager.startUpdatingLocation()
        }
        
        func stopUpdatingLocation() {
            manager.stopUpdatingLocation()
            locationContinuation?.finish()
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                manager.startUpdatingLocation()
                
            case .denied, .restricted:
                locationContinuation?.yield(with: .failure(InternalError.denied))
                
            default:
                break
            }
        }
        
        func locationManager(
            _ manager: CLLocationManager,
            didUpdateLocations locations: [CLLocation]
        ) {
            guard
                let item = locations.first
            else {
                locationContinuation?.yield(with: .failure(InternalError.unexpected))
                return
            }
            locationContinuation?.yield(with: .success(item))
        }
        
        func locationManager(
            _ manager: CLLocationManager,
            didFailWithError error: Error
        ) {
            locationContinuation?.yield(with: .failure(error))
        }
    }
}

private func buildCLLocationDistance(
    location: CLLocation,
    destination: MKMapItem
) async throws -> CLLocationDistance {
    let request = MKDirections.Request()
    request.source = .init(placemark: .init(coordinate: location.coordinate))
    request.destination = destination
    let directions = MKDirections(request: request)
    let response = try await directions.calculate()
    guard
        let item = response.routes.first?.distance
    else { throw LocationClient.InternalError.unexpected }
    
    return item
}

private extension ConferenceVenue {
    var mapItem: MKMapItem {
        switch self {
        case .aTCenter:
            return .init(
                placemark: .init(
                    coordinate: .init(
                        latitude: 37.465640,
                        longitude: 127.040311
                    )
                )
            )
        }
    }
}
