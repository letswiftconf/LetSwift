import CoreLocation
import ActivityKit
import Foundation
import SwiftUI

@available(iOS 16.1, *)
class LiveActivityStore: ObservableObject {
    @MainActor @Published var state = false
    private var activity: Activity<LocationAttributes>?
    private var taskList: [Task<Void, Never>] = []
    private let environmnet: Environment
    
    init(environment: Environment) {
        self.environmnet = environment
    }
    
    func buttonTapped() {
        guard
            taskList.isEmpty
        else {
            environmnet.locationClient.cancelStream()
            return
        }
        let task = Task {
            do {
                await toggle(item: true)
                let stream = try await environmnet
                    .locationClient
                    .distanceStream(.aTCenter)
                
                for try await item in stream {
                    if activity?.activityState == Optional(.active) {
                        await activity?.update(using: .init(movingState: .going(item)))
                    } else {
                        try buildActivity(item: item)
                    }
                }
                await toggle(item: false)
                await activity?.update(using: .init(movingState: .arrived))
            } catch {
                guard
                    !(error is CancellationError)
                else {
                    await toggle(item: false)
                    for _ in 0..<taskList.count {
                        taskList.removeFirst().cancel()
                    }
                    await activity?.end(dismissalPolicy: .immediate)
                    return
                }
                print("💥", error)
            }
        }
        taskList.append(task)
    }
    
    private func buildActivity(item: Double) throws {
        activity = try .request(
            attributes: .init(),
            contentState: .init(movingState: .going(item))
        )
        let task = Task { [activity, weak self] in
            guard let self = self else { return }
            if let activity {
                for await activityState in activity.activityStateUpdates {
                    switch activityState {
                    case .active:
                        break
                        
                    case .ended:
                        await toggle(item: false)
                        for _ in 0..<self.taskList.count {
                            self.taskList.removeFirst().cancel()
                        }
                        
                    case .dismissed:
                        await toggle(item: false)
                        environmnet.locationClient.cancelStream()
                        for _ in 0..<self.taskList.count {
                            self.taskList.removeFirst().cancel()
                        }
                        
                    default:
                        break
                    }
                }
            }
        }
        taskList.append(task)
    }
    
    @MainActor
    private func toggle(item: Bool) {
        withAnimation {
            state = item
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
