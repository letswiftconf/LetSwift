//
//  Video.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import Foundation
import OSLog

/// One year of Let'Swift talk videos.
struct Conference: Decodable, Identifiable, Hashable {
    let year: Int
    let videos: [Video]

    var id: Int { year }
}

/// A talk video on YouTube.
struct Video: Decodable, Identifiable, Hashable {
    /// YouTube video ID.
    let id: String
    let title: String
    let speaker: String?
    /// Video length, e.g. "20:31".
    let duration: String?
    /// Link to the talk's slides.
    let slides: URL?

    var watchURL: URL {
        URL(string: "https://www.youtube.com/watch?v=\(id)")!
    }

    /// 320×180 (16:9) thumbnail.
    var thumbnailURL: URL {
        URL(string: "https://i.ytimg.com/vi/\(id)/mqdefault.jpg")!
    }
}

// MARK: - VoiceOver

extension Video {
    /// `duration` the way VoiceOver should speak it: "20 minutes, 31 seconds" instead of "20:31",
    /// which a speech synthesizer reads as a time of day. `nil` if `duration` isn't m:ss or h:mm:ss.
    var spokenDuration: String? {
        guard let duration else { return nil }
        let fields = duration.split(separator: ":")
        let numbers = fields.compactMap { Int($0) }
        guard (2...3).contains(fields.count), numbers.count == fields.count else { return nil }
        let seconds = numbers.reduce(0) { $0 * 60 + $1 }
        return Duration.seconds(seconds)
            .formatted(.units(allowed: [.hours, .minutes, .seconds], width: .wide))
    }
}

/// All talk videos, read once from the bundled `videos.json` (newest year first).
enum VideoCatalog {
    static let conferences: [Conference] = {
        let logger = Logger(subsystem: "kr.codesquad.jk.letswift", category: "VideoCatalog")
        guard let url = Bundle.main.url(forResource: "videos", withExtension: "json") else {
            logger.error("videos.json is missing from the bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Conference].self, from: data)
                .sorted { $0.year > $1.year }
        } catch {
            logger.error("Failed to decode videos.json: \(error.localizedDescription)")
            return []
        }
    }()
}
