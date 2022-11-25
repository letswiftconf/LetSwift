import AsyncAlgorithms
import CoreLocation
import Foundation
import MapKit

@available(iOS 16.1, *)
struct LocationClient {
    let distanceStream: (_ venue: ConferenceVenue) async throws -> DistanceStream
    let cancelStream: () -> Void
}

@available(iOS 16.1, *)
extension LocationClient {
    typealias DistanceStream =
        AsyncFilterSequence<AsyncThrowingMapSequence<AsyncDebounceSequence<AsyncThrowingStream<CLLocation, Error>, ContinuousClock>, Double>>
    
    enum InternalError: Error {
        case denied
        case unexpected
    }
    
    static let live: LocationClient = {
        let manager = Manager()
        
        return LocationClient { @MainActor [manager] venue in
            manager.checkAuthorizationStatus()
            return try manager.locationStream()
                .debounce(for: .seconds(2))
                .map { @MainActor item in
                    do {
                        let distance = try await buildCLLocationDistance(
                            location: item,
                            destination: venue.mapItem
                        )
                        return distance as Double
                    } catch {
                        fatalError()
                    }
                }
                .filter { @MainActor item in
                    let flag = item > 1
                    flag ? nil : manager.stopUpdatingLocation(isCancelled: false)
                    return flag
                }
        } cancelStream: { [manager] in
            manager.stopUpdatingLocation(isCancelled: true)
        }
    }()
}

@available(iOS 16.1, *)
extension LocationClient {
    final class Manager: NSObject, CLLocationManagerDelegate {
        private lazy var manager: CLLocationManager = {
            let manager = CLLocationManager()
            manager.delegate = self
            manager.allowsBackgroundLocationUpdates = true
            manager.showsBackgroundLocationIndicator = true
            
            return manager
        }()
        private var locationContinuation: AsyncThrowingStream<CLLocation, Error>.Continuation?
        
        @MainActor
        func checkAuthorizationStatus() {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
                
            case .notDetermined:
                manager.requestAlwaysAuthorization()
                
            default:
                break
            }
        }
        
        func locationStream() throws -> AsyncThrowingStream<CLLocation, Error> {
            let flag = manager.authorizationStatus != .restricted &&
            manager.authorizationStatus != .denied
            guard flag else { throw InternalError.denied }
            return AsyncThrowingStream { [weak self] continuation in
                self?.locationContinuation = continuation
            }
        }
        
        func stopUpdatingLocation(isCancelled: Bool) {
            manager.stopUpdatingLocation()
            locationContinuation?.finish(throwing: isCancelled ? CancellationError() : nil)
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

@available(iOS 16.1, *)
@MainActor
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
    
    return item / 1000
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
