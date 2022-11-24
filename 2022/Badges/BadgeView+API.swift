//
//  BadgeView+API.swift
//  LetSwift
//
//  Created by Son on 2022/11/24.
//

import Foundation

extension BadgeView {
    
    func getQuestions() {
        NetworkManager.shared.call(api: .getQuestions, type: [QuestionModel].self).sink { data in
            if let data = data {
                self.questions = data
                self.filtering()
            }
        }.store(in: &anyCancellable)
    }
    
    func filtering() {
        self.filteredQuestions = self.questions.filter { item in
            !(SharedPreference().getObjectValues(key: "question_\(item.id)") as? Bool ?? false)
        }
    }
}
