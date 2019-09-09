//
//  NewVideoViewModel.swift
//  LetSwift Data Manager
//
//  Created by 김나용 on 09/09/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import Combine

class NewVideoViewModel: ObservableObject {
    
    // MARK: - Properties
    var urlString: String
    
    var hours: String
    var minutes: String
    var seconds: String
    
    // MARK: - Initialization
    init(video: Video? = nil) {
        self.urlString = video?.url.absoluteString ?? ""
        
        let hhmmss = video?.length.hhmmss
        self.hours = hhmmss?.hours ?? ""
        self.minutes = hhmmss?.minutes ?? ""
        self.seconds = hhmmss?.seconds ?? ""
    }
    
    // MARK: - Computed Variables
    var video: Video? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        return Video(url: url, length: timeInterval)
    }
    
    var timeInterval: TimeInterval {
        return TimeInterval.hours(Double(hours) ?? 0)
            + TimeInterval.minutes(Double(minutes) ?? 0)
            + TimeInterval.seconds(Double(seconds) ?? 0)
    }
}

extension NewVideoViewModel {
    static let dummy: NewVideoViewModel = NewVideoViewModel()
}
