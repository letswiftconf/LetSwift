import ActivityKit
import Foundation

struct LocationAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var distance: Double = .zero
        var isArrived: Bool = false
    }
}

enum ConferenceVenue {
    case kofst
}
