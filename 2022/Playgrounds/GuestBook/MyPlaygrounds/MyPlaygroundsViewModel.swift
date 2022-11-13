//
//  MyPlaygroundsViewModel.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/07.
//

import Foundation
import SwiftUI
import RxSwift
import RxRelay

class MyPlaygroundsViewModel: ObservableObject {
    var hasCheeringCard = false

    @Published var movies: [String] = []
    init(){
        
        //MARK: - 응원카드 작성 후 UserDefault 값 확인용 테스트코드
//        SharedPreference.shared.cheeringCard = CheeringCard(name: "나다나다")
//
//        guard let user = SharedPreference.shared.cheeringCard , let name = user.name else{
//            return
//        }
//
//        print("user \(user)")
//        hasCheeringCard = !name.isEmpty

    }
}


extension MyPlaygroundsViewModel {
    func getForegroundColor(_ isGuestBookViewHidden: Bool) -> Color {
        return isGuestBookViewHidden ? .gray : .orange
    }
    
    func getNextView(_ has: Bool) -> some View {
        if has {
            return AnyView(GoToGuestBookFormView())
        }else{
            return AnyView(GoToCardView())
        }
    }
    
}
