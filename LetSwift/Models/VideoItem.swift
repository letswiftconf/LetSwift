//
//  VideoItem.swift
//  LetSwift
//
//  Created by Hyun A Song on 9/26/24.
//

import Foundation

struct Conference: Decodable {
  let year: Int
  let items: [VideoItem]
}

struct VideoItem: Decodable, Identifiable {
    var id: String {
        videoID
    }
    
    var hasReference: Bool {
        !referenceLink.isEmpty
    }
    
    let title: String
    let speaker: String
    let timeLine: String
    let referenceLink: String
    let thumbnail: String
    let videoID: String
}
