import AsyncAlgorithms
import CoreLocation
import Foundation
import MapKit

@available(iOS 16.1, *)
struct LocationClient {
    let distanceStream: (_ venue: ConferenceVenue) async throws -> DistanceStream
    let cancelStream: (_ isFinished: Bool) -> Void
}

@available(iOS 16.1, *)
extension LocationClient {
    typealias DistanceStream =
    AsyncFilterSequence<AsyncThrowingMapSequence<AsyncThrottleSequence<AsyncThrowingStream<CLLocation, Error>, ContinuousClock, CLLocation>, Double>>
    
    enum InternalError: Error, LocalizedError {
        var errorDescription: String? {
            switch self {
            case .denied:
                return "위치 권한이 거부됐습니다. 설정에서 권한을 허용하신 후 다시 시도해주세요."
                
            case .unexpected:
                return "잠시 후에 다시 시도해주세요."
            }
        }
        
        case denied
        case unexpected
    }
    
    static let live: LocationClient = {
        let manager = Manager()
        
        return LocationClient { @MainActor [manager] venue in
            manager.checkAuthorizationStatus()
            return try manager.locationStream()
                .throttle(for: .seconds(2), latest: true)
                .map { item in
                    return try await buildCLLocationDistance(
                        location: item,
                        destination: venue.mapItem
                    )
                }
                .filter { [manager] in
                    let flag = $0 > 1
                    flag ? nil : manager.cancelStream(isFinished: true)
                    return flag
                }
        } cancelStream: { [manager] in
            manager.cancelStream(isFinished: $0)
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
            let stream = AsyncThrowingStream { [weak self] continuation in
                self?.locationContinuation = continuation
            }
            locationContinuation?.onTermination = { [weak self] _ in
                self?.manager.stopUpdatingLocation()
            }
            
            return stream
        }
        
        func cancelStream(isFinished: Bool) {
            locationContinuation?.finish(throwing: isFinished ? nil : CancellationError())
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
private func buildCLLocationDistance(
    location: CLLocation,
    destination: MKMapItem
) async throws -> Double {
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
