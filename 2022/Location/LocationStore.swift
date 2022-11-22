import CoreLocation
import ActivityKit
import Foundation

@available(iOS 16.1, *)
class LiveActivityStore: ObservableObject {
    private var activity: Activity<LocationAttributes>?
    private let environmnet: Environment
    
    init(environment: Environment) {
        self.environmnet = environment
        do {
            activity = try .request(attributes: .init(), contentState: .init(movingState: .going(.zero)))
        } catch {
            /// MARK: - Handle error
        }
    }
    
    func buttonTapped() {
        Task {
            do {
                let stream = environmnet.locationClient
                    .distanceStream(.aTCenter)
                for try await item in stream {
                    guard let movingState = activity?.contentState.movingState else { return }
                    switch movingState {
                    case let .going(distance):
                        if distance != item {
                            await activity?.update(using: .init(movingState: .going(item)))
                        }
                        
                    case .arrived:
                        break
                    }
                }
                await activity?.update(using: .init(movingState: .arrived))
            } catch {
                print("💥", error)
                guard !(error is CancellationError) else { return }
                /// MARK: - Handle error
            }
        }
    }
}

@available(iOS 16.1, *)
extension LiveActivityStore {
    static let live = LiveActivityStore(environment: .live)
    
    struct Environment {
        static let live = Self(locationClient: .live)
        let locationClient: LocationClient
    }
}
