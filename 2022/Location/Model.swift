import ActivityKit
import Foundation

struct LocationAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        let movingState: MovingState
    }
}

extension LocationAttributes {
    enum MovingState: Codable, Hashable {
        case going(Double)
        case arrived
    }
}

enum ConferenceVenue {
    case aTCenter
}
