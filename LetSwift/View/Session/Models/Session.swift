//
//  Session.swift
//  LetSwift
//
//  Created by 박진서 on 8/30/24.
//

import Foundation

struct Session: Identifiable, Codable, Equatable {
    static func == (lhs: Session, rhs: Session) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let name: String
    let nameEn: String
    let type: String
    let track: String
    let trackEn: String
    let venue: String
    let venueEn: String
    let speaker: Speaker?
    let startTime: Date
    let duration: Int
    let endTime: Date
    let keynoteUrl: String
    let videoUrl: String

    enum CodingKeys: String, CodingKey {
        case id, name, type, track, venue, speaker, duration
        case nameEn = "name_en"
        case trackEn = "track_en"
        case venueEn = "venue_en"
        case startTime = "start_time"
        case endTime = "end_time"
        case keynoteUrl = "keynote_url"
        case videoUrl = "video_url"
    }
    
    struct Speaker: Codable {
        let id: String
        let name: String
        let nameEn: String
        let imageName: String
        let imageUrl: String
        let description: String
        let social: SocialMedia

        enum CodingKeys: String, CodingKey {
            case id, name, description, social
            case nameEn = "name_en"
            case imageName = "image_name"
            case imageUrl = "image_url"
        }
    }
    
    struct SocialMedia: Codable {
        let web: String
        let email: String
        let github: String
        let linkedin: String
        let x: String
        let mastodon: String
        let facebook: String
        let instagram: String
        let thread: String
        let youtube: String
    }
}
