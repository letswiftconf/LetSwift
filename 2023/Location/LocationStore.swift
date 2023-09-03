import CoreLocation
import ActivityKit
import Foundation
import SwiftUI

@available(iOS 16.1, *)
class LiveActivityStore: ObservableObject {
    @MainActor @Published var state: State
    private let environmnet: Environment
    
    private var taskList: [Task<Void, Never>] = []
    
    init(
        initialState: State,
        environment: Environment
    ) {
        self._state = .init(initialValue: initialState)
        self.environmnet = environment
    }
    
    func buttonTapped() {
        guard
            taskList.isEmpty
        else {
            environmnet.locationClient.cancelStream(false)
            Task { @MainActor [weak self] in
                self?.state.isLiveActivityVisible = false
            }
            return
        }
        let task = Task { @MainActor [weak self, environmnet] in
            do {
                self?.state.isLiveActivityVisible = true
                let stream = try await environmnet
                    .locationClient
                    .distanceStream(.kofst)
                
                for try await item in stream {
                    if self?.state.liveActivity?.activityState == Optional(.active) {
                        if self?.state.liveActivity?.contentState.distance != Optional(item) {
                            await self?.state.liveActivity?.update(using: .init(distance: item))
                        }
                    } else {
                        try self?.buildActivity(distance: item)
                    }
                }
                self?.cancelTasks()
                await self?.state.liveActivity?.update(using: .init(isArrived: true))
            } catch is CancellationError {
                self?.cancelTasks()
                await self?.state.liveActivity?.end(dismissalPolicy: .immediate)
            } catch {
                self?.cancelTasks(error: error)
            }
        }
        taskList.append(task)
    }
    
    @MainActor
    private func buildActivity(distance: Double) throws {
        state.liveActivity = try .request(
            attributes: .init(),
            contentState: .init(distance: distance)
        )
        let task = Task { [weak self, state, environmnet] in
            if let liveActivity = state.liveActivity {
                for await activityState in liveActivity.activityStateUpdates {
                    switch activityState {
                    case .active:
                        break
                        
                    case .ended:
                        self?.cancelTasks()
                        
                    case .dismissed:
                        environmnet.locationClient.cancelStream(false)
                        self?.cancelTasks()
                        
                    default:
                        break
                    }
                }
            }
        }
        taskList.append(task)
    }
    
    @MainActor
    private func cancelTasks(error: Error? = nil) {
        state.isLiveActivityVisible = false
        taskList.indices
            .forEach { [weak self] _ in self?.taskList.removeFirst().cancel() }
        state.error = error
    }
}

@available(iOS 16.1, *)
extension LiveActivityStore {
    static let live = LiveActivityStore(
        initialState: .init(),
        environment: .live
    )
    
    struct State {
        var isLiveActivityVisible: Bool = false
        var isButtonVisible: Bool = true
        var liveActivity: Activity<LocationAttributes>?
        var error: Error?
    }
    
    struct Environment {
        static let live = Self(locationClient: .live)
        let locationClient: LocationClient
    }
}
