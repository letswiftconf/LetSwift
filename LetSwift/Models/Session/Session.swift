//
//  Session.swift
//  LetSwift
//
//  Created by 박진서 on 8/30/24.
//

import Foundation

extension Session {
    var speakerNames: String {
        return self.speakers.map { $0.name }.joined(separator: "&")
    }
}

struct Session: Identifiable, Codable {
    let id: Int
    let title: String
    let type: String
    let track: String
    let speakers: [Speaker]
    let startTime: Date
    let endTime: Date

    struct Speaker: Identifiable, Codable {
        var id: String { self.name }
        let name: String
        let profileImage: String

        enum CodingKeys: String, CodingKey {
            case name
            case imageUrl = "image_url"
            case profileImage
        }

        init(name: String, profileImage: String) {
            self.name = name
            self.profileImage = profileImage
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            // Try new format (image_url) first, fallback to legacy (profileImage)
            if let imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) {
                self.profileImage = imageUrl
            } else {
                self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
            try container.encode(profileImage, forKey: .imageUrl)
        }
    }

    // New API format keys
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case track
        case speakers
        case startTime = "start_time"
        case endTime = "end_time"
    }

    // Old cached format keys (for backwards compatibility)
    enum LegacyCodingKeys: String, CodingKey {
        case id
        case title
        case track
        case speakers
        case startTime
        case endTime
    }

    init(id: Int, title: String, type: String = "presentation", track: String, speakers: [Speaker], startTime: Date, endTime: Date) {
        self.id = id
        self.title = title
        self.type = type
        self.track = track
        self.speakers = speakers
        self.startTime = startTime
        self.endTime = endTime
    }

    init(from decoder: Decoder) throws {
        // Try new format first
        if let container = try? decoder.container(keyedBy: CodingKeys.self),
           container.contains(.name) {
            // New API format: id as String, name field, snake_case dates
            let idString = try container.decode(String.self, forKey: .id)
            self.id = Int(idString) ?? 0
            self.title = try container.decode(String.self, forKey: .name)
            self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? "presentation"

            let fullTrack = try container.decode(String.self, forKey: .track)
            // Handle both English "Track A/B" and Korean "트랙 A/B"
            self.track = fullTrack
                .replacingOccurrences(of: "Track ", with: "")
                .replacingOccurrences(of: "트랙 ", with: "")

            self.speakers = try container.decode([Speaker].self, forKey: .speakers)
            self.startTime = try container.decode(Date.self, forKey: .startTime)
            self.endTime = try container.decode(Date.self, forKey: .endTime)
        } else {
            // Legacy format: id as Int, title field, camelCase dates
            let container = try decoder.container(keyedBy: LegacyCodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.title = try container.decode(String.self, forKey: .title)
            self.type = "presentation"
            self.track = try container.decode(String.self, forKey: .track)
            self.speakers = try container.decode([Speaker].self, forKey: .speakers)
            self.startTime = try container.decode(Date.self, forKey: .startTime)
            self.endTime = try container.decode(Date.self, forKey: .endTime)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(String(id), forKey: .id)
        try container.encode(title, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode("Track \(track)", forKey: .track)
        try container.encode(speakers, forKey: .speakers)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(endTime, forKey: .endTime)
    }
}
