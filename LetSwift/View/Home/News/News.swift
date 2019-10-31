//
//  News.swift
//  LetSwift
//
//  Created by HyungJung Kim on 31/10/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine


class News: Identifiable, Codable, ObservableObject {
    
    // MARK: - init
    
    init(title: String, date: Date, description: String) {
        self.title = title
        self.description = description
        self.date = date
    }
    
    // MARK: - internal
    
    let objectWillChange = ObservableObjectPublisher()
    let id = UUID()
    
    var title: String { willSet { self.objectWillChange.send() } }
    var date: Date { willSet { self.objectWillChange.send() } }
    var description: String { willSet { self.objectWillChange.send() } }
    
    // MARK: - private
    
    private enum CodingKeys: String, CodingKey {
        
        case id, title, date, description
        
    }
    
}


extension News {
    
    // MARK: - dummy
    
    static var dummy: [News] {
        return [
            News(title: "모임 종료 안내",
                 date: Date(),
                 description: "모임이 모두 종료되었습니다. 본 웹사이트의 소스코드는 GitHub에 공개되어있습니다. 모임 사진은 구글 드라이브에서 확인하실 수 있습니다. 발표 자료와 영상은 각 세션 설명에 첨부된 링크를 확인해주세요.")
        ]
    }
    
}
