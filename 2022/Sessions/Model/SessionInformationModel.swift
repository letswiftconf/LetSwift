//
//  SessionInformationModel.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

struct SessionInformationModel {
  let rowType: ScheduleRowType
  let placeType: PlaceType
  let time: SessionInformationModel.Time
  let titleString: String
  let contentString: String
  let speaker: SessionInformationModel.Speaker
  
  init(
    rowType: ScheduleRowType,
    placeType: PlaceType,
    time: SessionInformationModel.Time,
    titleString: String,
    contentString: String = "",
    speaker: SessionInformationModel.Speaker = .empty
  ) {
    self.rowType = rowType
    self.placeType = placeType
    self.time = time
    self.titleString = titleString
    self.contentString = contentString
    self.speaker = speaker
  }
}

extension SessionInformationModel {
  struct Time {
    let startString: String
    let endString: String
  }
  
  struct Speaker {
    let nameString: String
    let companyString: String
    let introductionString: String
    let profileImage: Image
  }
}

extension SessionInformationModel: Identifiable, Equatable {
  var id: UUID { return UUID() }
  
  static func == (lhs: SessionInformationModel, rhs: SessionInformationModel) -> Bool {
    // FIXME: fix to id: UUID
    return lhs.titleString == rhs.titleString
  }
}

extension SessionInformationModel.Speaker {
  static let empty: SessionInformationModel.Speaker = .init(
    nameString: "",
    companyString: "",
    introductionString: "",
    profileImage: Image.Dummy.profile
  )
}
