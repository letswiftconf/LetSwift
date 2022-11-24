//
//  QuestionData.swift
//  LetSwift
//
//  Created by Son on 2022/11/18.
//

import Foundation

class QuestionModel : Codable, ObservableObject {
    var id: Int
    var question: String
    var answer: String
    
    var sessionRes: QuestionSessionModel
    var speakerRes: QuestionSpeakerModel
}

struct QuestionSessionModel : Codable {
    var startTime: String
    var endTime: String
    var title: String
    var content: String
    var place: String
}

struct QuestionSpeakerModel : Codable {
    var name: String
    var role: String
    var description: String
}

extension QuestionModel {
    func toSessionInfomation() -> SessionInformationModel {
        SessionInformationModel(rowTypeString: "", placeTypeString: "",
                                startTimeString: sessionRes.startTime,
                                endTimeString: sessionRes.endTime,
                                titleString: sessionRes.title,
                                contentString: sessionRes.content,
                                speaker: SessionInformationModel.SessionSpeakerModel(
                                    nameString: speakerRes.name,
                                    roleString: speakerRes.role,
                                    descriptionString: speakerRes.description,
                                    profileString: ""
                                )
        )
    }
    
    func isCorreted() -> Bool {
        return SharedPreference().getObjectValues(key: "question_\(self.id)") as? Bool ?? false
    }
}

extension QuestionSessionModel {
    func getTime() -> String {
        return "\(startTime) - \(endTime)"
    }
}
