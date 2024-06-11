import CoreLocation
import ActivityKit
import Foundation
import SwiftUI

@available(iOS 16.1, *)
@MainActor
class LiveActivityStore: ObservableObject {
  @Published var state: State
  private var locationStreamTask: Task<Void, Never>?
  private var liveActivityTask: Task<Void, Never>?
  
  private let environmnet: Environment
  
  init(
    initialState: State,
    environment: Environment
  ) {
    self._state = .init(initialValue: initialState)
    self.environmnet = environment
  }
  
  func buttonTapped() {
    if let _ = locationStreamTask {
      locationStreamTask?.cancel()
      liveActivityTask?.cancel()
      state.isLiveActivityVisible = false
    } else {
      buildLocationTask()
    }
  }
  
  private func buildLocationTask() {
    locationStreamTask = Task {
      defer { locationStreamTask = nil }
      do {
        let stream = try environmnet.locationClient.distanceStream(venue: .kofst)
        state.isLiveActivityVisible = true
        for try await distance in stream {
          try Task.checkCancellation()
          if state.liveActivity?.activityState == .active {
            await state.liveActivity?.update(using: .init(distance: distance))
          } else {
            try buildActivity(distance: distance)
          }
        }
        try Task.checkCancellation()
        state.isLiveActivityVisible = false
        await state.liveActivity?.update(using: .init(isArrived: true))
      } catch is CancellationError {
        state.isLiveActivityVisible = false
        await state.liveActivity?.end(dismissalPolicy: .immediate)
      } catch {
        state.isLiveActivityVisible = false
        state.error = error
      }
    }
  }
  
  private func buildActivity(distance: Double) throws {
    state.liveActivity = try .request(
      attributes: .init(),
      contentState: .init(distance: distance)
    )
    liveActivityTask = Task {
      defer { liveActivityTask = nil }
      if let liveActivity = state.liveActivity {
        for await activityState in liveActivity.activityStateUpdates {
          switch activityState {
          case .ended, .dismissed:
            liveActivityTask?.cancel()
          default:
            break
          }
        }
      }
    }
  }
}

@available(iOS 16.1, *)
extension LiveActivityStore {
  @MainActor
  static let live = LiveActivityStore(
    initialState: .init(),
    environment: .live
  )
  
  struct State {
    var isLiveActivityVisible: Bool? = nil
    var isButtonVisible: Bool = true
    var liveActivity: Activity<LocationAttributes>?
    var error: Error?
  }
  
  struct Environment {
    @MainActor
    static let live = Self(locationClient: .live)
    let locationClient: LocationClient
  }
}
