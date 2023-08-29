//
//  SessionInformationModel.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

struct SessionInformationModel: Decodable {
    let rowTypeString: String
    let placeTypeString: String
    let startTimeString: String
    let endTimeString: String
    let titleString: String
    let contentString: String
    let speaker: SessionSpeakerModel?
  
  enum CodingKeys: String, CodingKey {
    case rowTypeString = "rowType"
    case placeTypeString = "place"
    case startTimeString = "startTime"
    case endTimeString = "endTime"
    case titleString = "title"
    case contentString = "content"
    case speaker = "speaker"
  }
}

extension SessionInformationModel {
    struct SessionSpeakerModel: Decodable {
        let nameString: String
        let roleString: String
        let descriptionString: String
        let profileString: String
      
      enum CodingKeys: String, CodingKey {
        case nameString = "name"
        case roleString = "role"
        case descriptionString = "description"
        case profileString = "profile"
      }
    }
}

extension SessionInformationModel: Identifiable, Equatable {
    var id: UUID { return UUID() }
    
    static func == (lhs: SessionInformationModel, rhs: SessionInformationModel) -> Bool {
        // FIXME: fix to id: UUID
        return lhs.titleString == rhs.titleString
    }
}
